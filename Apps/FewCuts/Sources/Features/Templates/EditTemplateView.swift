//
//  EditTemplateView.swift
//  FewCuts
//
//  Created by 송영모 on 6/4/25.
//

import SwiftUI

@Observable
public class TemplateModel {
    var layer: Layer
    var textBlocks: [TextBlock]
    var imageBlocks: [ImageBlock]
    
    // 최소한의 전역 상태만 유지
    var activeDragComponentID: BlockID? = nil
    
    // 크기 조절 관련 상태
    var isResizeActive: Bool = false
    var resizeStartRect: CGRect? = nil
    var resizeAnchorPoint: CGPoint? = nil // 고정 앵커 포인트
    var resizeStartScale: CGFloat = 1.0
    var magnificationCenter: CGPoint? = nil // MagnificationGesture의 중심점
    var initialDistance: CGFloat = 0 // 초기 두 손가락 간 거리
    var currentSize: CGSize = .zero // 현재 크기
    var currentOffset: CGPoint = .zero // 현재 오프셋
    
    public init(layer: Layer, textBlocks: [TextBlock], imageBlocks: [ImageBlock]) {
        self.layer = layer
        self.textBlocks = textBlocks
        self.imageBlocks = imageBlocks
    }
    
    // MARK: - 드래그 관리 메서드
    func startDrag(for blockID: BlockID) {
        activeDragComponentID = blockID
        print("🔵 활성 컴포넌트 설정: \(blockID)")
    }
    
    func endDrag() {
        activeDragComponentID = nil
        endResize()
        print("🔴 활성 컴포넌트 해제")
    }
    
    // MARK: - 크기 조절 관리 메서드 (Size & Offset 기반)
    func handleResizeStart(magnification: CGFloat, at location: CGPoint) {
        guard activeDragComponentID != nil, !isResizeActive else { return }
        
        // 크기 조절 시작
        isResizeActive = true
        resizeStartRect = getCurrentActiveRect()
        magnificationCenter = location
        
        if let rect = resizeStartRect {
            // 앵커 포인트 설정 (좌상단 고정)
            resizeAnchorPoint = CGPoint(x: rect.minX, y: rect.minY)
            
            // 초기 값들 설정
            currentSize = rect.size
            currentOffset = rect.origin
            initialDistance = 100.0 // 기준 거리 (임의 값)
            
            print("🟠 크기조절 시작: 앵커=\(resizeAnchorPoint!), 초기크기=\(currentSize), 초기위치=\(currentOffset)")
        }
    }
    
    func handleResize(magnification: CGFloat, at location: CGPoint) {
        guard activeDragComponentID != nil, isResizeActive else { return }
        guard let startRect = resizeStartRect, let anchor = resizeAnchorPoint else { return }
        
        // magnification 값을 크기 변화량으로 변환 (1.0 = 원본 크기)
        let sizeMultiplier = max(0.3, min(3.0, magnification))
        
        // 새로운 크기 계산
        let newWidth = max(50, startRect.width * sizeMultiplier)
        let newHeight = max(50, startRect.height * sizeMultiplier)
        
        // 앵커 포인트 기준으로 새로운 위치 계산
        let newOffset = calculateOffsetFromAnchor(
            anchorPoint: anchor,
            originalRect: startRect,
            newSize: CGSize(width: newWidth, height: newHeight)
        )
        
        // 경계 제한 적용
        let constrainedSizeAndOffset = applyBoundaryConstraints(
            offset: newOffset,
            size: CGSize(width: newWidth, height: newHeight)
        )
        
        currentSize = constrainedSizeAndOffset.size
        currentOffset = constrainedSizeAndOffset.offset
        
        // 새로운 rect 적용
        let newRect = CGRect(origin: currentOffset, size: currentSize)
        applyResizeToActiveComponent(newRect: newRect)
        
        print("🟢 Size/Offset 조절: 배율=\(String(format: "%.3f", sizeMultiplier)), 크기=\(String(format: "(%.1f, %.1f)", currentSize.width, currentSize.height)), 위치=\(String(format: "(%.1f, %.1f)", currentOffset.x, currentOffset.y))")
    }
    
    func endResize() {
        print("🟠 크기조절 종료")
        isResizeActive = false
        resizeStartRect = nil
        resizeAnchorPoint = nil
        magnificationCenter = nil
        initialDistance = 0
        currentSize = .zero
        currentOffset = .zero
    }
    
    // MARK: - Size & Offset 계산 헬퍼 메서드
    private func calculateOffsetFromAnchor(anchorPoint: CGPoint, originalRect: CGRect, newSize: CGSize) -> CGPoint {
        // 앵커 포인트가 고정되도록 offset 계산
        switch anchorPoint {
        case CGPoint(x: originalRect.minX, y: originalRect.minY): // 좌상단 앵커
            return anchorPoint
        case CGPoint(x: originalRect.maxX, y: originalRect.minY): // 우상단 앵커
            return CGPoint(x: anchorPoint.x - newSize.width, y: anchorPoint.y)
        case CGPoint(x: originalRect.minX, y: originalRect.maxY): // 좌하단 앵커
            return CGPoint(x: anchorPoint.x, y: anchorPoint.y - newSize.height)
        case CGPoint(x: originalRect.maxX, y: originalRect.maxY): // 우하단 앵커
            return CGPoint(x: anchorPoint.x - newSize.width, y: anchorPoint.y - newSize.height)
        default: // 기본값: 좌상단 앵커
            return anchorPoint
        }
    }
    
    private func applyBoundaryConstraints(offset: CGPoint, size: CGSize) -> (offset: CGPoint, size: CGSize) {
        var constrainedOffset = offset
        var constrainedSize = size
        
        // 왼쪽 경계
        if constrainedOffset.x < 0 {
            constrainedSize.width += constrainedOffset.x
            constrainedOffset.x = 0
        }
        
        // 위쪽 경계
        if constrainedOffset.y < 0 {
            constrainedSize.height += constrainedOffset.y
            constrainedOffset.y = 0
        }
        
        // 오른쪽 경계
        if constrainedOffset.x + constrainedSize.width > layer.size.width {
            constrainedSize.width = layer.size.width - constrainedOffset.x
        }
        
        // 아래쪽 경계
        if constrainedOffset.y + constrainedSize.height > layer.size.height {
            constrainedSize.height = layer.size.height - constrainedOffset.y
        }
        
        // 최소 크기 보장
        constrainedSize.width = max(50, constrainedSize.width)
        constrainedSize.height = max(50, constrainedSize.height)
        
        return (offset: constrainedOffset, size: constrainedSize)
    }
    
    // MARK: - 내부 헬퍼 메서드
    private func findBestAnchorPoint(touchLocation: CGPoint, rect: CGRect) -> CGPoint {
        // 터치 위치에서 가장 가까운 모서리를 찾아 앵커로 설정
        let corners = [
            CGPoint(x: rect.minX, y: rect.minY), // 좌상단
            CGPoint(x: rect.maxX, y: rect.minY), // 우상단
            CGPoint(x: rect.minX, y: rect.maxY), // 좌하단
            CGPoint(x: rect.maxX, y: rect.maxY)  // 우하단
        ]
        
        var closestCorner = corners[0]
        var minDistance = distance(touchLocation, corners[0])
        
        for corner in corners {
            let dist = distance(touchLocation, corner)
            if dist < minDistance {
                minDistance = dist
                closestCorner = corner
            }
        }
        
        // 가장 가까운 모서리의 반대편을 앵커로 사용 (더 직관적)
        if closestCorner.x == rect.minX && closestCorner.y == rect.minY {
            return CGPoint(x: rect.maxX, y: rect.maxY) // 좌상단 -> 우하단 앵커
        } else if closestCorner.x == rect.maxX && closestCorner.y == rect.minY {
            return CGPoint(x: rect.minX, y: rect.maxY) // 우상단 -> 좌하단 앵커
        } else if closestCorner.x == rect.minX && closestCorner.y == rect.maxY {
            return CGPoint(x: rect.maxX, y: rect.minY) // 좌하단 -> 우상단 앵커
        } else {
            return CGPoint(x: rect.minX, y: rect.minY) // 우하단 -> 좌상단 앵커
        }
    }
    
    private func distance(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func getCurrentActiveRect() -> CGRect? {
        guard let activeID = activeDragComponentID else { return nil }
        
        if let index = textBlocks.firstIndex(where: { $0.id == activeID }) {
            return textBlocks[index].rect
        }
        
        if let index = imageBlocks.firstIndex(where: { $0.id == activeID }) {
            return imageBlocks[index].rect
        }
        
        return nil
    }
    
    private func applyResizeToActiveComponent(newRect: CGRect) {
        guard let activeID = activeDragComponentID else { return }
        
        // 텍스트 블록 크기 조절
        if let index = textBlocks.firstIndex(where: { $0.id == activeID }) {
            textBlocks[index].rect = newRect
            return
        }
        
        // 이미지 블록 크기 조절
        if let index = imageBlocks.firstIndex(where: { $0.id == activeID }) {
            imageBlocks[index].rect = newRect
            return
        }
    }
    
    // MARK: - 바인딩 헬퍼
    func getBinding(for blockID: BlockID) -> Binding<CGRect> {
        // 텍스트 블록 확인
        if let index = textBlocks.firstIndex(where: { $0.id == blockID }) {
            return Binding(
                get: { self.textBlocks[index].rect },
                set: { self.textBlocks[index].rect = $0 }
            )
        }
        
        // 이미지 블록 확인
        if let index = imageBlocks.firstIndex(where: { $0.id == blockID }) {
            return Binding(
                get: { self.imageBlocks[index].rect },
                set: { self.imageBlocks[index].rect = $0 }
            )
        }
        
        // 기본값 (이런 일은 없어야 함)
        return .constant(CGRect.zero)
    }
}

public struct TemplateEditor: View {
    @State var model: TemplateModel
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(model.layer.color)
                    .border(.gray, width: 1)
                
                // 이미지 블록들
                ForEach(model.imageBlocks) { block in
                    DraggableContainerView(
                        parentSize: model.layer.size,
                        rect: model.getBinding(for: block.id),
                        componentID: block.id,
                        onDragStarted: model.startDrag,
                        onDragEnded: model.endDrag
                    ) {
                        Rectangle()
                            .frame(width: block.rect.width, height: block.rect.height)
                    }
                }
                
                // 텍스트 블록들  
                ForEach(model.textBlocks) { block in
                    DraggableContainerView(
                        parentSize: model.layer.size,
                        rect: model.getBinding(for: block.id),
                        componentID: block.id,
                        onDragStarted: model.startDrag,
                        onDragEnded: model.endDrag
                    ) {
                        Text(block.text)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .frame(width: model.layer.size.width, height: model.layer.size.height)
            .simultaneousGesture(
                MagnificationGesture(minimumScaleDelta: 0.05)
                    .onChanged { value in
                        // 실제 제스처 중심점을 사용하기 위해 현재 활성 컴포넌트의 중심을 사용
                        var gestureLocation = CGPoint(
                            x: model.layer.size.width / 2,
                            y: model.layer.size.height / 2
                        )
                        
                        // 활성 컴포넌트가 있다면 그 컴포넌트의 중심을 기준으로 설정
                        if let activeRect = model.getCurrentActiveRect() {
                            gestureLocation = CGPoint(x: activeRect.midX, y: activeRect.midY)
                        }
                        
                        if !model.isResizeActive {
                            model.handleResizeStart(magnification: value, at: gestureLocation)
                        } else {
                            model.handleResize(magnification: value, at: gestureLocation)
                        }
                    }
                    .onEnded { _ in
                        model.endResize()
                    }
            )
        }
    }
}

public struct EditTemplateView: View {
    var model: TemplateModel
    
    init() {
        self.model = .init(
            layer: .init(color: .red, size: .init(width: 400, height: 600)),
            textBlocks: [
                .init(rect: CGRect(x: 50, y: 50, width: 100, height: 30), text: "Sample Text")
            ],
            imageBlocks: []
        )
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                TemplateEditor(
                    model: self.model
                )
                
                HStack(spacing: 20) {
                    ToolButton(systemImageName: "swatchpalette") {
                        let sizes: [CGSize] = [
                            CGSize(width: 200, height: 400),
                            CGSize(width: 280, height: 600),
                            CGSize(width: 320, height: 700),
                            CGSize(width: 350, height: 750)
                        ]
                        model.layer.size = sizes.randomElement() ?? CGSize(width: 280, height: 600)
                        model.layer.color = [Color.black, Color.blue, Color.red, Color.green].randomElement() ?? Color.black
                    }
                    
                    ToolButton(systemImageName: "grid") {
                        
                    }
                    
                    ToolButton(systemImageName: "textformat") {
                        let newTextBlock = TextBlock(
                            rect: CGRect(x: 50, y: 50 + CGFloat(model.textBlocks.count * 40), width: 100, height: 30),
                            text: "New Text"
                        )
                        model.textBlocks.append(newTextBlock)
                    }
                    
                    ToolButton(systemImageName: "photo") {
                        let newImageBlock = ImageBlock(
                            rect: CGRect(x: 60, y: 60 + CGFloat(model.imageBlocks.count * 60), width: 120, height: 80)
                        )
                        model.imageBlocks.append(newImageBlock)
                    }
                }
                .padding(.vertical, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

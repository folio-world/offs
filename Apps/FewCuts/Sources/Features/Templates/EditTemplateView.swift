//
//  EditTemplateView.swift
//  FewCuts
//
//  Created by 송영모 on 6/4/25.
//

import SwiftUI
import IdentifiedCollections

@Observable
public class TemplateModel {
    var layer: Layer
    var textBlocks: IdentifiedArray<BlockID, TextBlock>
    var imageBlocks: IdentifiedArray<BlockID, ImageBlock>
    
    // 최소한의 전역 상태만 유지
    var activeDragComponentID: BlockID? = nil
    
    // 크기 조절 관련 상태를 TemplateModel로 이동
    var resizeStartScale: CGFloat = 1.0
    var isResizeActive: Bool = false
    var resizeStartRect: CGRect? = nil
    var resizeStartCenter: CGPoint? = nil // 고정된 중심점
    
    public init(layer: Layer, textBlocks: [TextBlock], imageBlocks: [ImageBlock]) {
        self.layer = layer
        self.textBlocks = .init(uniqueElements: textBlocks)
        self.imageBlocks = .init(uniqueElements: imageBlocks)
    }
    
    // MARK: - 드래그 관리 메서드
    func startDrag(for blockID: BlockID) {
        activeDragComponentID = blockID
        print("🔵 활성 컴포넌트 설정: \(blockID)")
    }
    
    func endDrag() {
        activeDragComponentID = nil
        isResizeActive = false
        resizeStartRect = nil
        resizeStartCenter = nil
        print("🔴 활성 컴포넌트 해제")
    }
    
    // MARK: - 크기 조절 관리 메서드
    func handleResize(scale: CGFloat) {
        guard activeDragComponentID != nil else { return }
        
        // 실제 pinch 제스처인지 확인 (scale이 1.0에서 충분히 벗어났는지)
        let scaleThreshold: CGFloat = 0.05
        if abs(scale - 1.0) < scaleThreshold && !isResizeActive {
            return // 미세한 변화는 무시 (한 손 드래그 시 발생하는 노이즈)
        }
        
        // 크기 조절이 처음 시작되는 경우
        if !isResizeActive {
            isResizeActive = true
            resizeStartScale = scale
            resizeStartRect = getCurrentActiveRect()
            resizeStartCenter = resizeStartRect.map { CGPoint(x: $0.midX, y: $0.midY) }
            print("🟠 피치 제스처 시작: 시작 scale=\(scale), 시작 rect=\(String(describing: resizeStartRect))")
            return // 첫 번째 호출에서는 크기 조절하지 않고 기준점만 설정
        }
        
        // 크기 조절 계산 및 적용
        let scaleChange = scale / resizeStartScale
        let clampedScale = max(0.3, min(3.0, scaleChange))
        
        print("🟠 크기 조절 계산: 현재=\(scale), 시작=\(resizeStartScale), 변화비율=\(scaleChange)")
        
        applyResizeToActiveComponent(scale: clampedScale)
    }
    
    func endResize() {
        print("🟠 피치 제스처 종료")
        isResizeActive = false
        resizeStartScale = 1.0
        resizeStartRect = nil
        resizeStartCenter = nil
    }
    
    // MARK: - 내부 헬퍼 메서드
    private func getCurrentActiveRect() -> CGRect? {
        guard let activeID = activeDragComponentID else { return nil }
        
        if let index = textBlocks.firstIndex(where: { $0.id == activeID }) {
            return textBlocks[index].rect
        }
        
        if let index = imageBlocks.firstIndex(where: { $0.id == activeID }) {
            return imageBlocks[index].rect
        }
        
        return nil
    }
    
    private func applyResizeToActiveComponent(scale: CGFloat) {
        guard let activeID = activeDragComponentID else { return }
        
        // 텍스트 블록 크기 조절
        if let index = textBlocks.firstIndex(where: { $0.id == activeID }) {
            let newRect = calculateResizedRect(scale: scale)
            textBlocks[index].rect = newRect
            print("🟢 텍스트 블록 크기 조절: \(newRect)")
            return
        }
        
        // 이미지 블록 크기 조절
        if let index = imageBlocks.firstIndex(where: { $0.id == activeID }) {
            let newRect = calculateResizedRect(scale: scale)
            imageBlocks[index].rect = newRect
            print("🟢 이미지 블록 크기 조절: \(newRect)")
            return
        }
    }
    
    private func calculateResizedRect(scale: CGFloat) -> CGRect {
        guard let startRect = resizeStartRect,
              let centerPoint = resizeStartCenter else { return CGRect.zero }
        
        let newWidth = max(50, min(startRect.width * scale, layer.size.width))
        let newHeight = max(50, min(startRect.height * scale, layer.size.height))
        
        // 고정된 중심점을 사용하여 깜빡거림 방지
        let newOrigin = CGPoint(
            x: centerPoint.x - newWidth / 2,
            y: centerPoint.y - newHeight / 2
        )
        
        // 경계 제한
        let clampedX = min(max(newOrigin.x, 0), layer.size.width - newWidth)
        let clampedY = min(max(newOrigin.y, 0), layer.size.height - newHeight)
        
        return CGRect(x: clampedX, y: clampedY, width: newWidth, height: newHeight)
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
            MagnificationGesture(minimumScaleDelta: 0.1)
                .onChanged { value in
                    print("🟠 피치 제스처 감지됨: scale=\(value), 활성 컴포넌트: \(String(describing: model.activeDragComponentID))")
                    
                    model.handleResize(scale: value)
                }
                .onEnded { _ in
                    model.endResize()
                }
        )
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

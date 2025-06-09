//
//  DraggableContainerView.swift
//  FewCuts
//
//  Created by 송영모 on 6/9/25.
//

import SwiftUI

public struct DraggableContainerView<Content: View>: View {
    public let parentSize: CGSize
    @Binding public var rect: CGRect
    public let content: Content
    public let componentID: BlockID
    
    public let onDragStarted: (BlockID) -> Void
    public let onDragEnded: () -> Void
    public let onResizeChanged: (CGFloat) -> Void

    @State private var dragStartOrigin: CGPoint? = nil
    @State private var resizeStartRect: CGRect? = nil

    public init(
        parentSize: CGSize, 
        rect: Binding<CGRect>, 
        componentID: BlockID,
        onDragStarted: @escaping (BlockID) -> Void = { _ in },
        onDragEnded: @escaping () -> Void = {},
        onResizeChanged: @escaping (CGFloat) -> Void = { _ in },
        content: @escaping () -> Content
    ) {
        self.parentSize = parentSize
        self._rect = rect
        self.componentID = componentID
        self.onDragStarted = onDragStarted
        self.onDragEnded = onDragEnded
        self.onResizeChanged = onResizeChanged
        self.content = content()
    }

    public var body: some View {
        let center = CGPoint(x: rect.midX, y: rect.midY)

        ZStack {
            content
                .frame(width: rect.width, height: rect.height)
                .position(center)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if dragStartOrigin == nil {
                                print("🔵 드래그 시작: \(componentID)")
                                dragStartOrigin = rect.origin
                                onDragStarted(componentID)
                            }
                            
                            // 기본 드래그 이동
                            let base = dragStartOrigin!
                            let movedOrigin = CGPoint(
                                x: base.x + value.translation.width,
                                y: base.y + value.translation.height
                            )
                            let clampedOrigin = clampOrigin(movedOrigin, size: rect.size)
                            rect = CGRect(origin: clampedOrigin, size: rect.size)
                        }
                        .onEnded { _ in
                            print("🔴 드래그 종료: \(componentID)")
                            dragStartOrigin = nil
                            resizeStartRect = nil
                            onDragEnded()
                        }
                )
        }
        .frame(width: parentSize.width, height: parentSize.height)
        .clipped()
    }
    
    // 외부에서 크기 조절을 트리거하는 메서드
    public func applyResize(scale: CGFloat) {
        if resizeStartRect == nil {
            resizeStartRect = rect
            print("🟢 크기 조절 시작, 시작 rect: \(rect)")
        }
        
        guard let startRect = resizeStartRect else { return }
        
        // 중심점 유지하면서 크기 조절
        let newWidth = max(50, min(startRect.width * scale, parentSize.width))
        let newHeight = max(50, min(startRect.height * scale, parentSize.height))
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        // 중심점을 기준으로 새로운 origin 계산
        let centerPoint = CGPoint(x: startRect.midX, y: startRect.midY)
        let newOrigin = CGPoint(
            x: centerPoint.x - newSize.width / 2,
            y: centerPoint.y - newSize.height / 2
        )
        
        // 부모 영역을 벗어나지 않도록 제한
        let clampedOrigin = clampOrigin(newOrigin, size: newSize)
        rect = CGRect(origin: clampedOrigin, size: newSize)
        
        print("🟢 크기 조절 적용: scale=\(scale), 새 크기: \(newSize)")
    }

    private func clampOrigin(_ origin: CGPoint, size: CGSize) -> CGPoint {
        let minX: CGFloat = 0
        let maxX = max(0, parentSize.width - size.width)
        let minY: CGFloat = 0
        let maxY = max(0, parentSize.height - size.height)
        return CGPoint(
            x: min(max(origin.x, minX), maxX),
            y: min(max(origin.y, minY), maxY)
        )
    }
}

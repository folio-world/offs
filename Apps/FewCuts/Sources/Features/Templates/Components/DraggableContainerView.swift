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
    public let componentID: AnyHashable
    
    // 전역 상태 바인딩
    @Binding public var isDraggingAnyComponent: Bool
    @Binding public var draggingComponentID: AnyHashable?
    @Binding public var globalResizeScale: CGFloat
    @Binding public var isResizeGestureActive: Bool

    // 로컬 드래그 상태
    @State private var dragStartOrigin: CGPoint? = nil
    @State private var resizeStartRect: CGRect? = nil

    public init(
        parentSize: CGSize, 
        rect: Binding<CGRect>, 
        componentID: AnyHashable,
        isDraggingAnyComponent: Binding<Bool>,
        draggingComponentID: Binding<AnyHashable?>,
        globalResizeScale: Binding<CGFloat>,
        isResizeGestureActive: Binding<Bool>,
        content: @escaping () -> Content
    ) {
        self.parentSize = parentSize
        self._rect = rect
        self.componentID = componentID
        self._isDraggingAnyComponent = isDraggingAnyComponent
        self._draggingComponentID = draggingComponentID
        self._globalResizeScale = globalResizeScale
        self._isResizeGestureActive = isResizeGestureActive
        self.content = content()
    }

    public var body: some View {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let isThisComponentBeingDragged = draggingComponentID == componentID

        ZStack {
            content
                .frame(width: rect.width, height: rect.height)
                .position(center)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // 첫 번째 드래그 시작
                            if dragStartOrigin == nil {
                                print("🔵 드래그 시작: \(componentID)")
                                dragStartOrigin = rect.origin
                                isDraggingAnyComponent = true
                                draggingComponentID = componentID
                                globalResizeScale = 1.0
                            }
                            
                            // 드래그로 이동 (크기 조절 중이 아닐 때만)
                            if globalResizeScale == 1.0 {
                                let base = dragStartOrigin!
                                let movedOrigin = CGPoint(
                                    x: base.x + value.translation.width,
                                    y: base.y + value.translation.height
                                )
                                let clampedOrigin = clampOrigin(movedOrigin, size: rect.size)
                                rect = CGRect(origin: clampedOrigin, size: rect.size)
                            }
                        }
                        .onEnded { _ in
                            print("🔴 드래그 종료: \(componentID)")
                            dragStartOrigin = nil
                            isDraggingAnyComponent = false
                            draggingComponentID = nil
                            // globalResizeScale은 리셋하지 않음 (크기 유지)
                            resizeStartRect = nil
                        }
                )
        }
        .frame(width: parentSize.width, height: parentSize.height)
        .clipped()
        .onChange(of: globalResizeScale) { oldValue, newValue in
            print("🟡 크기 조절 값 변화: \(oldValue) -> \(newValue), 현재 드래그 중인 컴포넌트: \(String(describing: draggingComponentID)), 내 ID: \(componentID), 크기 조절 활성: \(isResizeGestureActive)")
            
            // 이 컴포넌트가 드래그 중이고, 크기 조절 제스처가 활성상태인 경우만 처리
            if isThisComponentBeingDragged && isResizeGestureActive && newValue != 1.0 {
                if resizeStartRect == nil {
                    resizeStartRect = rect
                    print("🟢 크기 조절 시작, 시작 rect: \(rect)")
                }
                
                guard let startRect = resizeStartRect else { return }
                
                // 중심점 유지하면서 크기 조절
                let newWidth = max(50, min(startRect.width * newValue, parentSize.width))
                let newHeight = max(50, min(startRect.height * newValue, parentSize.height))
                
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
                
                print("🟢 크기 조절 적용: scale=\(newValue), 새 크기: \(newSize)")
            }
        }
        .onChange(of: isResizeGestureActive) { _, isActive in
            // 크기 조절 제스처가 비활성화되면 resizeStartRect 초기화
            if !isActive {
                resizeStartRect = nil
                print("🟢 크기 조절 제스처 비활성화, resizeStartRect 초기화")
            }
        }
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

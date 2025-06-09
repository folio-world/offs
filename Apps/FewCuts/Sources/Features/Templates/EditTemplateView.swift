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
    var textBlocks: IdentifiedArray<TextBlock.ID, TextBlock>
    var imageBlocks: IdentifiedArray<ImageBlock.ID, ImageBlock>
    
    // 전역 제스처 상태 관리
    var isDraggingAnyComponent: Bool = false
    var draggingComponentID: AnyHashable? = nil
    var globalResizeScale: CGFloat = 1.0
    var resizeStartScale: CGFloat = 1.0  // 피치 제스처 시작 시의 scale
    var isResizeGestureActive: Bool = false
    
    public init(layer: Layer, textBlocks: [TextBlock], imageBlocks: [ImageBlock]) {
        self.layer = layer
        self.textBlocks = .init(uniqueElements: textBlocks)
        self.imageBlocks = .init(uniqueElements: imageBlocks)
    }
    

}

public struct TemplateEditor: View {
    @State var model: TemplateModel
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(model.layer.color)
                .border(.gray, width: 1)
            
            ForEach(model.imageBlocks) { block in
                DraggableContainerView(
                    parentSize: model.layer.size,
                    rect: Binding(
                        get: { block.rect },
                        set: { block.rect = $0 }
                    ),
                    componentID: block.id,
                    isDraggingAnyComponent: Binding(
                        get: { model.isDraggingAnyComponent },
                        set: { model.isDraggingAnyComponent = $0 }
                    ),
                    draggingComponentID: Binding(
                        get: { model.draggingComponentID },
                        set: { model.draggingComponentID = $0 }
                    ),
                    globalResizeScale: Binding(
                        get: { model.globalResizeScale },
                        set: { model.globalResizeScale = $0 }
                    ),
                    isResizeGestureActive: Binding(
                        get: { model.isResizeGestureActive },
                        set: { model.isResizeGestureActive = $0 }
                    )
                ) {
                    Rectangle()
                        .frame(width: block.rect.width, height: block.rect.height)
                }
            }
            
            ForEach(model.textBlocks) { block in
                DraggableContainerView(
                    parentSize: model.layer.size,
                    rect: Binding(get: { block.rect }, set: { block.rect = $0 }),
                    componentID: block.id,
                    isDraggingAnyComponent: Binding(
                        get: { model.isDraggingAnyComponent },
                        set: { model.isDraggingAnyComponent = $0 }
                    ),
                    draggingComponentID: Binding(
                        get: { model.draggingComponentID },
                        set: { model.draggingComponentID = $0 }
                    ),
                    globalResizeScale: Binding(
                        get: { model.globalResizeScale },
                        set: { model.globalResizeScale = $0 }
                    ),
                    isResizeGestureActive: Binding(
                        get: { model.isResizeGestureActive },
                        set: { model.isResizeGestureActive = $0 }
                    )
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
            // 멀티터치 피치 제스처 - 두 손가락으로 크기 조절
            MagnificationGesture()
                .onChanged { value in
                    print("🟠 피치 제스처 감지됨: scale=\(value), 현재 드래그 중?: \(model.isDraggingAnyComponent)")
                    
                    if model.isDraggingAnyComponent {
                        // 피치 제스처가 처음 시작되는 경우
                        if !model.isResizeGestureActive {
                            model.isResizeGestureActive = true
                            model.resizeStartScale = value
                            print("🟠 피치 제스처 시작: 시작 scale=\(value)")
                        }
                        
                        // 시작 scale 대비 변화량 계산 (자연스러운 크기 조절)
                        let scaleChange = value / model.resizeStartScale
                        let clampedScale = max(0.3, min(3.0, scaleChange))
                        
                        print("🟠 크기 조절 계산: 현재=\(value), 시작=\(model.resizeStartScale), 변화비율=\(scaleChange), 제한된 scale=\(clampedScale)")
                        model.globalResizeScale = clampedScale
                    }
                }
                .onEnded { _ in
                    print("🟠 피치 제스처 종료")
                    // 피치 제스처 종료 - 상태 초기화하지만 크기는 유지
                    model.isResizeGestureActive = false
                    model.resizeStartScale = 1.0
                    model.globalResizeScale = 1.0  // 다음 크기 조절을 위해 1.0으로 리셋
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

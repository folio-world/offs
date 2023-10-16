//
//  EditHeaderView.swift
//  OffSharedDesignSystem
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftUI

public enum OffEditMode {
    case add
    case edit
    case select
    
    public enum Action {
        case dismiss
        case new
        case delete
    }
}

public struct OffEditHeaderView: View {
    public let mode: OffEditMode
    public let title: LocalizedStringKey
    public let isShowDismissButton: Bool
    public let isShowNewButton: Bool
    public let isShowDeleteButton: Bool
    
    public var action: (OffEditMode.Action) -> ()
    
    public init(
        mode: OffEditMode,
        title: LocalizedStringKey,
        isShowDismissButton: Bool = false,
        isShowNewButton: Bool = false,
        isShowDeleteButton: Bool = false,
        action: @escaping (OffEditMode.Action) -> Void
    ) {
        self.mode = mode
        self.title = title
        self.isShowDismissButton = isShowDismissButton
        self.isShowNewButton = isShowNewButton
        self.isShowDeleteButton = isShowDeleteButton
        
        self.action = action
    }
    
    public var body: some View {
        HStack {
            if isShowDismissButton {
                Button(action: {
                    action(.dismiss)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundStyle(.foreground)
                })
            }
            
            Text(title)
                .font(.title)
            
            Spacer()
            
            if isShowDeleteButton {
                Button(action: {
                    action(.delete)
                }, label: {
                    Image(systemName: "trash.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
            
            if isShowNewButton {
                Button(action: {
                    action(.new)
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
        }
    }
}

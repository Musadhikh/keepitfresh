//
//
//  CreateHouseSheet.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: CreateHouseSheet is a SwiftUI view that presents a form for creating a new household. It includes fields for the house name, address, and description, along with "Create House" and "Cancel" buttons. The view handles keyboard management to ensure the form remains accessible when the keyboard is active.
//
    

import SwiftUI

struct CreateHouseSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let isSubmitting: Bool
    let onCancel: () -> Void
    let onSubmit: (String, String, String) -> Void
    
    @State private var name = ""
    @State private var address = ""
    @State private var note = ""
    @State private var keyboardInset: CGFloat = 0
    @FocusState private var focusedField: Field?
    
    private enum Field {
        case name
        case address
        case note
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                    VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                        Text("Create New House")
                            .font(Theme.Fonts.display(24, weight: .bold, relativeTo: .title2))
                            .foregroundStyle(Theme.Colors.textPrimary)
                            .padding(.top)
                        
                        Text("Add the details for your new household.")
                            .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .body))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                    .padding(.bottom)
                    
                    IconTextField(
                        title: "House Name *",
                        icon: .homeTab,
                        placeholder: "Green Family",
                        text: $name
                    )
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .address
                    }
                    .focused($focusedField, equals: .name)
                    
                    IconTextField(
                        title: "Address",
                        icon: .locationPin,
                        placeholder: "Downtown Flat",
                        text: $address
                    )
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .note
                    }
                    .focused($focusedField, equals: .address)
                    
                    VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                        Text("Description")
                            .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .body))
                            .foregroundStyle(Theme.Colors.textSecondary)
                        
                        TextField("Description (optional)", text: $note, axis: .vertical)
                            .lineLimit(3...6)
                            .textFieldStyle(.plain)
                            .font(Theme.Fonts.bodyRegular)
                            .foregroundStyle(Theme.Colors.textPrimary)
                            .padding(12)
                            .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r16))
                            .overlay {
                                RoundedRectangle(cornerRadius: Theme.Radius.r16)
                                    .stroke(Theme.Colors.border, lineWidth: 1)
                            }
                            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
                            .focused($focusedField, equals: .note)
                    }
                    
                    HStack(spacing: Theme.Spacing.s12) {
                        Button("Create House") {
                            onSubmit(name, address, note)
                        }
                        .primaryButtonStyle()
                        .disabled(isSubmitting || name.isEmpty)
                        
                        Button("Cancel") {
                            dismissKeyboard()
                            onCancel()
                            dismiss()
                        }
                        .buttonStyle(.borderless)
                        .disabled(isSubmitting)
                        .frame(minWidth: 100)
                    }
                    .padding(.top, Theme.Spacing.s16)
                }
                .padding(.horizontal, Theme.Spacing.s20)
                .padding(.top, Theme.Spacing.s20)
                .padding(.bottom, max(keyboardInset, Theme.Spacing.s20))
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
            .background(Theme.Colors.surface)
            .onTapGesture {
                dismissKeyboard()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { notification in
                updateKeyboardInset(notification: notification, proxy: proxy)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation(.easeInOut(duration: 0.25)) {
                    keyboardInset = 0
                }
            }
            
        }
    }
    
    private func dismissKeyboard() {
        focusedField = nil
    }
    
    private func updateKeyboardInset(notification: Notification, proxy: GeometryProxy) {
        guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let viewFrame = proxy.frame(in: .global)
        let overlap = max(0, viewFrame.maxY - endFrame.minY)
        let padding: CGFloat = 16
        withAnimation(.easeInOut(duration: 0.25)) {
            keyboardInset = overlap + padding
        }
    }
}

#Preview("House Selection - Required") {
    NavigationStack {
        HouseSelectionScreen(mode: .required)
            .environment(AppState())
    }
}

#Preview("House Selection - Sheet") {
    NavigationStack {
        VStack {
            
        }
        .sheet(isPresented: .constant(true)) {
            CreateHouseSheet(
                isSubmitting: false,
                onCancel: {  },
                onSubmit: {_,_,_ in }
            )
            .presentationDetents([.height(600), .large])
            .presentationDragIndicator(.visible)
            
        }
    }
}

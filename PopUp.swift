import SwiftUI

struct PopUp: View {
    
    //MARK: - Variables
    @Binding private var isPresented: Bool
    private let title: String
    private let message: String
    private let mainButtonTitle: String
    private let defaultButtonTitle: String
    private let mainAction: () -> Void
    private let defaultAction: () -> Void
    private let buttonsOrientation: ButtonsOrientation
    
    enum ButtonsOrientation {
        case vertical
        case horizontal
    }
    
    private enum ButtonType {
        case main
        case defaultButton
        
        var backgroundColor: UIColor {
            switch self {
            case .main:
                UIColor(red: 60/255, green: 179/255, blue: 113/255, alpha: 1)
            case .defaultButton:
                UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
            }
        }
    }
    
    //MARK:  Init
    init(isPresented: Binding<Bool>, title: String, message: String, mainButtonTitle: String = "", defaultButtonTitle: String = "", mainAction: @escaping () -> Void = {}, defaultAction: @escaping () -> Void = {}, buttonsOrientation: ButtonsOrientation = .vertical) {
        self.title = title
        self.message = message
        self._isPresented = isPresented
        self.mainButtonTitle = mainButtonTitle
        self.defaultButtonTitle = defaultButtonTitle
        self.mainAction = mainAction
        self.defaultAction = defaultAction
        self.buttonsOrientation = buttonsOrientation
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            HStack {
                VStack {
                    PopUpTitle(title)
                    Spacer().frame(height: 18)
                    PopUpMessage(message)
                    Spacer().frame(height: 30)
                    switch buttonsOrientation {
                    case .vertical:
                        VerticalButtons()
                    case .horizontal:
                        HorizontalButtons()
                    }
                }
                .minimumScaleFactor(0.5)
                .padding(26)
                .padding(.top, -6)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 8)).border(Color.black, width: 0.5)
            }
            .frame(width: .infinity)
            .padding(.horizontal, 40)
        }
        .opacity($isPresented.wrappedValue ? 1 : 0)
        .animation(.easeIn(duration: 0.25), value: isPresented)
        .onTapGesture {
            isPresented.toggle()
        }
    }
    
    //MARK: - Design
    private func PopUpTitle(_ title: String) -> some View {
        Text(title)
            .kerning(1.1)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(Color.black.opacity(0.8))
            .multilineTextAlignment(.center)
    }
    
    private func PopUpMessage(_ message: String) -> some View {
        Text(message)
            .kerning(1.1)
            .font(.body)
            .foregroundColor(Color.black.opacity(0.8))
            .multilineTextAlignment(.center)
    }
    
    private func ButtonPopUp(type: ButtonType, title: String, action: @escaping () -> Void) -> some View {
        return Button {
            withAnimation {
                action()
            }
        } label: {
            Text(title)
                .foregroundColor(Color.white)
                .font(.title3)
                .fontWeight(.bold)
                .kerning(1.1)
                .minimumScaleFactor(0.5)
                .padding(.vertical, 8)
                .padding(.horizontal, 22)
        }
        .frame(maxWidth: .infinity)
        .background(Color(type.backgroundColor))
        .border(Color.black, width: 0.4)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .minimumScaleFactor(0.5)
    }
    
    //MARK: - Functions
    private func VerticalButtons() -> some View {
        VStack(spacing: 14) {
            if mainButtonTitle != "" {
                ButtonPopUp(type: .main, title: mainButtonTitle, action: mainAction)
            }
            if defaultButtonTitle != "" {
                ButtonPopUp(type: .defaultButton, title: defaultButtonTitle, action: defaultAction)
            }
        }
    }
    
    private func HorizontalButtons() -> some View {
       return  HStack(spacing: 14) {
            if mainButtonTitle != "" {
                ButtonPopUp(type: .main, title: mainButtonTitle, action: mainAction)
            }
            if defaultButtonTitle != "" {
                ButtonPopUp(type: .defaultButton, title: defaultButtonTitle, action: defaultAction)
            }
        }
    }
}

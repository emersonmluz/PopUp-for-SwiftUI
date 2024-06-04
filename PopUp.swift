import SwiftUI

struct PopUp: View {
    
    @Binding private var isPresented: Bool
    private let title: String
    private let message: String
    private let mainButtonTitle: String
    private let alternativeButtonTitle: String
    private let mainAction: () -> Void
    private let alternativeAction: () -> Void
    private var popUpOpacity: Double {
        if $isPresented.wrappedValue {
            return 1
        } else {
            return 0
        }
    }
    
    init(isPresented: Binding<Bool>, title: String, message: String, mainButtonTitle: String, alternativeButtonTitle: String = "", mainAction: @escaping () -> Void, alternativeAction: @escaping () -> Void = {}) {
        self.title = title
        self.message = message
        self._isPresented = isPresented
        self.mainButtonTitle = mainButtonTitle
        self.alternativeButtonTitle = alternativeButtonTitle
        self.mainAction = mainAction
        self.alternativeAction = alternativeAction
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            HStack {
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        Text(title)
                            .kerning(1.1)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.7))
                            .multilineTextAlignment(.center)
                        Spacer()
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundColor(Color.black.opacity(0.7))
                            .onTapGesture {
                                withAnimation {
                                    isPresented.toggle()
                                }
                            }
                    }
                    Spacer().frame(height: 24)
                    Text(message)
                        .kerning(1.1)
                        .font(.body)
                        .foregroundColor(Color.black.opacity(0.7))
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 30)
                    VStack(spacing: 14) {
                        ButtonPopUp(type: .main, title: mainButtonTitle, action: mainAction)
                        if alternativeButtonTitle != "" {
                            ButtonPopUp(type: .alternative, title: alternativeButtonTitle, action: alternativeAction)
                        }
                    }
                }
                .minimumScaleFactor(0.5)
                .padding(26)
                .padding(.top, -6)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 8)).border(Color.black, width: 0.5)
                .opacity(popUpOpacity)
                .animation(.easeIn(duration: 0.25), value: isPresented)
            }
            .frame(width: .infinity)
            .padding(.horizontal, 40)
        }
        .opacity(popUpOpacity)
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
        .background(type.backgroundColor)
        .border(Color.black, width: 0.4)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .minimumScaleFactor(0.5)
    }
    
    enum ButtonType {
        case main
        case alternative
        
        var backgroundColor: Color {
            switch self {
            case .main:
                Color.green
            case .alternative:
                Color.orange
            }
        }
    }
}

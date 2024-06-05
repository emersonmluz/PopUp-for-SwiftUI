# PopUp-for-SwiftUI

##Como Usar

O Pop-up deve ser declarado com a seguinte sintaxe:

PopUp (
  isPresented: $popUpIsPresented,
  title: "Título do pop-up",
  message: "Mensagem do pop-up",
  mainButtonTitle: "Título do botão principal",
  alternativeButtonTitle: "Título do botão alternativo",
  mainAction: { Ação do botão principal },
  alternativeAction: { Ação do botão alternativo }
)

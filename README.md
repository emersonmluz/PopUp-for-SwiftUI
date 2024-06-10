# PopUp-for-SwiftUI

![exemplo3](https://github.com/emersonmluz/PopUp-for-SwiftUI/assets/111133275/3e2db4fb-8feb-4034-8bbd-52b3e139112f)

![exemplo1](https://github.com/emersonmluz/PopUp-for-SwiftUI/assets/111133275/e9fd08ab-913b-4a2b-bf9b-2572dce11b7a)

![exemplo2](https://github.com/emersonmluz/PopUp-for-SwiftUI/assets/111133275/786fdc30-385a-4418-be0f-0f80b7d0e897)

## Como Usar

O Pop-up deve ser declarado com a seguinte sintaxe:

PopUp(isPresented: $isPresented,
      title: "Conteúdo externo",
      message: "O conteúdo será aberto em um aplicativo externo, deseja continuar?",
      mainButtonTitle: "Continuar",
      defaultButtonTitle: "Cancelar",
      mainAction: { action() },
      defaultAction: { isPresented.toggle() },
      buttonsOrientation: .vertical
)

Atenção: O conteúdo do seu código deve estar em uma VStack e o PopUp deve ser o último componente.

# FastLocation — desafio SENAI

Aplicativo Flutter para consultar endereço por CEP, buscar CEP por endereço, salvar consultas no Hive, consultar histórico e abrir rota até o último endereço consultado.

## Ambiente necessário (Windows)
- Flutter SDK (inclui Dart): https://docs.flutter.dev/get-started/install/windows
- Android Studio e Android SDK: https://developer.android.com/studio
- VS Code: https://code.visualstudio.com/
- Extensões Flutter e Dart no VS Code.
- Criar um emulador Android (AVD) no Android Studio.

## Executar
```bash
flutter doctor
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter devices
flutter run
```
O `build_runner` gera os arquivos `*.g.dart` usados pelo MobX (stores reativas) e pelo Hive (adapter do `AddressModel`). Rode-o novamente sempre que alterar um controller ou o model.

## Testes
```bash
flutter analyze
flutter test
```
- CEP: selecione “Por CEP” e informe `01001000`.
- Endereço: selecione “Por endereço”, informe UF `SP`, cidade `São Paulo` e logradouro `Praça da Sé`.
- Histórico: faça consultas e toque no ícone de histórico.

A busca por endereço usa o formato oficial do ViaCEP, que exige UF, cidade e logradouro. O histórico é persistido localmente pelo Hive.

## Organização do projeto
```
lib/
  main.dart                 # bootstrap, injeção de dependências e rotas nomeadas
  src/
    http/                   # configuração do Dio (cliente HTTP para o ViaCEP)
    routes/                 # nomes das rotas do app
    shared/
      colors/               # paleta de cores do app
      components/           # componentes reaproveitados entre módulos (ex.: loading)
      metrics/               # constantes de espaçamento
      storage/               # configuração do Hive (armazenamento local)
    modules/
      initial/page/          # splash screen com animação e redirecionamento automático
      home/
        model/                # AddressModel (retorno do ViaCEP + persistência Hive)
        repositories/         # AddressApiRepository (API) e AddressLocalRepository (Hive)
        service/              # AddressService (regras de negócio) e MapService (rotas)
        controller/           # HomeController (MobX, com geração de código)
        components/           # AddressList, LastAddressCard, EmptySearch
        page/                 # HomePage
      history/
        controller/           # HistoryController (MobX)
        page/                 # HistoryPage
```

## Observação sobre a rota
A ação "Traçar rota" usa `geocoding` para localizar o endereço, `geolocator` para a posição atual do dispositivo e `map_launcher` para abrir o app de mapas instalado. É necessário aceitar a permissão de localização no dispositivo/emulador.

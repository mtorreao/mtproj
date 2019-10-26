# MTProj

> A console Application for help me develop new projects faster

### Install

```
git clone https://github.com/mtorreao/mtproj.git
cd mtproj
pub get
```

### Release Version

Commands to execute
```
dart2aot bin/main.dart bin/main.dart.aot
dartaotruntime bin/main.dart.aot
pub global activate --source path <PATH TO YOU PROJECT in my case it's ~/develop/mtproj>
```

### Features

- [X] Comando create - cria um projeto em flutter e usa o slidy para gerar o template inicial.
- [X] Comando github - cria um repositorório no github e faz o push inital do projeto.
- [ ] Comando widgets - baixa ou atualiza o repositório padrão com os templates que uso para projetos.
- [ ] Comando firebase - implementa o firebase no projeto.

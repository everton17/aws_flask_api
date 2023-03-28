
# AWS EC2 Manage Instances API

Este projeto foi desenvolvido como objeto de estudos e aplicação de uma série de conhecimentos, tecnologias e habilidades voltados para o ecossistema DevOps. Trabalhando alguns tópicos como: Programção, Cloud, IaC, Containers e CI/CD.

O core do projeto se trata de uma aplicação que possibilita interações simples com serviço AWS EC2 via requisições HTTP, como por exemplo Listar instancias e realizar algumas ações com as mesmas como: ligar, desligar, reiniciar e modificar a classe das instancias.


## 🛠 Stack utilizada

**Aplicação:** Python, Flask, Flask-Restful, Boto3, Gunicorn

**Infraestrutura:** AWS, Terraform, Docker, ECS (Elastic Container Service)

**CI/CD:** GitHub Actions 


## ✅ API - Pré requisitos

Para utilização da aplicação precisaremos de alguns itens instados no nosso ambiente:

- Uma conta AWS, usuário e credenciais com permissçõees ao serviço EC2
- Python 3.10
- AWS Cli


## 🔗 Links

Segue abaixo alguns links que pode ajudar na configuração do ambiente

[Instalação do Python e AWS Cli no Windows](https://docs.aws.amazon.com/pt_br/elasticbeanstalk/latest/dg/eb-cli3-install-windows.html)

[Instalação do Python e AWS Cli no Linux](https://docs.aws.amazon.com/pt_br/elasticbeanstalk/latest/dg/eb-cli3-install-linux.html)

[Criando um usário AWS no console AWS](https://docs.aws.amazon.com/pt_br/IAM/latest/UserGuide/id_users_create.html#id_users_create_console)

[Configurando credenciais de usuário no AWS Cli](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-configure-files.html)


## 🏠 Executando localmente

Após a configuração do ambiente e das credenciais de usuário junto aos AWS Cli basta seguir os passos abaixo:

**Obs: Para usuários windows recomendado utilizar o WSL2**

Clone o projeto

```bash
  git clone https://github.com/everton17/aws_flask_api.git
```

Entre no diretório do projeto

```bash
  cd aws_flask_api
```

Crie uma virtual-env

```bash
  python3 -m venv .venv
```

Ative a Virtual-env

```bash
  source .venv/bin/activate
```

Instale as bibliotecas do projeto

```bash
  pip install -r requirements.txt
```

Execute a aplicação

```bash
  gunicorn --bind 0.0.0.0:5000 -w 4 run:app
```

## 🐳 Executando localmente com Docker

Após a configuração do ambiente e das credenciais de usuário junto aos AWS Cli basta seguir os passos abaixo:

**Obs: para esta execução você necessariamente do docker intalado na sua maquina**

[Instalação do Docker](https://docs.docker.com/get-docker/)


Clone o projeto

```bash
  git clone https://github.com/everton17/aws_flask_api.git
```

Entre no diretório do projeto

```bash
  cd aws_flask_api
```

Entre no diretório do projeto

```bash
  cd aws_flask_api
```

Execute o docker build referenciando as credenciais AWS como build-args

```bash
  docker build -t aws_ec2_flask_api . --build-arg ACCESS_KEY=<AWS_ACCESS_KEY> --build-arg SECRET_KEY=<AWS_SECRET_ACCESS_KEY>
```

Agora vamos executar o container da nossa aplicação

```bash
  docker run -d --name aws-api -p 127.0.0.1:5000:5000 aws_ec2_flask_api:latest
```

## ☁️ Executando na Cloud AWS

Para execução da nossa aplicação na AWS o projeto contempla uma Stack Terraform, onde faremos o deploy através de uma pipeline CI/CD utilizando o GitHub Actions

**Obs: para esta execução você precisará fazer um fork do projeto e algumas configurações no seu GitHub e na sua conta AWS**

Para que possamos deployar nossa stack terraform na AWS precisaremos cumprir alguns pré requisitos:

**AWS**
-
- Criar um Bucket S3 para armazenar nosso Terraform Remote State
- Criar um novo usuário na AWS com permissões para criar e destruir recursos dos seguintes serviços:
    - EC2
    - ECR
    - ECS
    - VPC
    - Cloud Watch Logs

**GitHub**
-
Após feito o Fork, acesse as configurações do repositório em: **Settings > Secrets and variables > Actions** para que possamos criar nossas Secrets.
- Criaremos sete secrets ao todo, seram elas:
    - AWS_ACCESS_KEY_APP -> Recebera a Acess Key do usuário que criamos para nossa aplicação.
    - AWS_SECRET_ACCESS_KEY_APP -> Recebera a Secret Key do usuário que criamos para nossa aplicação.
    - AWS_ACCESS_KEY_CI_CD -> Recebera a Acess Key do usuário que criamos para o Terraform.
    - AWS_SECRET_ACCESS_KEY_CI_CD -> Recebera a Secret Key do usuário que criamos para o Terraform.
    - RS_BUCKET_NAME -> Recebera o nome do bucket que criamos para armazenar o Remote State do Terraform
    - RS_KEY_PATH_FILE -> Receberá o caminho seguido do nome do arquivo de state que será criado pelo Terraform. Ex: aws_infra/terraform.tfstate
    - RS_REGION -> Receberá a região da AWS onde o bucket foi criado
Detalhados os conteúdos cada secret deve conter, basta cria-las nas configurações do seu repositório GitHub

**Terraform**
-
Caso queira personalisar as configurações de infraestrutura , basta fazer as alterações no seguinte arquivo **./terraform/variables.tf**. Todas os parâmetros de configurações da nossa Stack Terraform se encontram no mesmo. Recomendo que você dê uma atenção especial a este arquivo e suas configurações antes de realizar o deploy, para que tome conhecimento de todos os recursos que serão provisionados e possa fazer sua estimativa de custos afim de estar ciente de todos custos que serão gerados por parte do Cloud Provider.

**Executando a Pipeline de Deploy**
-
Agora vamos Finalmente fazer o deploy de toda nossa Stack na AWS. Para isso acesse a Actions do seu repositório e execute o seguinte Workflow: **Deploy Full - Infrastructure and Application** clicando em **Run Workflow**.

**Executando a Pipeline de Destroy**
-
Quando não for mais utilizar a aplicação, não se esqueça de excluir os recusros criados na AWS a fim de evitar cobranças indesejadas. Para isso acesse a Actions do seu repositório e execute o seguinte Workflow: **Workflow Destroy Infrastructure** clicando em **Run Workflow**.

## 🤓  Conhecendo a aplicação

Nossa aplicação consiste em uma api que que se comunica com o serviço AWS EC2 e interagem com as instancias ali provisionadas por meio de requisições HTTP. Vamos conhecer mais de suas funcionalidades e como utiliza-las.

## 📑 Documentação da API

#### Retorna todas as Instancias EC2

```bash
  GET /ec2_list
```

| Parâmetro       | Tipo       | Descrição                                           |
| :----------     | :--------- | :---------------------------------------------------|
| `region`        | `string`   | **Obrigatório**. Região AWS que deseja interagir    |

#### Desliga uma instancia EC2

```bash
  POST /ec2_stop
```

| Parâmetro       | Tipo       | Descrição                                           |
| :----------     | :--------- | :---------------------------------------------------|
| `region`        | `string`   | **Obrigatório**. Região AWS que deseja interagir    |
| `instance_id`   | `string`   | **Obrigatório**. Id da Instacia que deseja desligar |

#### Liga uma instancia EC2

```bash
  POST /ec2_start
```

| Parâmetro       | Tipo       | Descrição                                           |
| :----------     | :--------- | :---------------------------------------------------|
| `region`        | `string`   | **Obrigatório**. Região AWS que deseja interagir    |
| `instance_id`   | `string`   | **Obrigatório**. Id da Instacia que deseja ligar    |

#### Reinicia uma instancia EC2

```bash
  POST /ec2_reboot
```

| Parâmetro       | Tipo       | Descrição                                           |
| :----------     | :--------- | :---------------------------------------------------|
| `region`        | `string`   | **Obrigatório**. Região AWS que deseja interagir    |
| `instance_id`   | `string`   | **Obrigatório**. Id da Instacia que deseja reiniciar|

#### Modifica o tipo da instancia EC2

```bash
  POST /ec2_instance_type_modify
```

| Parâmetro       | Tipo       | Descrição                                           |
| :----------     | :--------- | :---------------------------------------------------|
| `region`        | `string`   | **Obrigatório**. Região AWS que deseja interagir    |
| `instance_id`   | `string`   | **Obrigatório**. Id da Instacia que deseja reiniciar|
| `instance_type` | `string`   | **Obrigatório**. Novo tipo de instancia desejado    |

## ⚙️ Terraform

Toda a infraestrutura do projeto foi desenvolvida de forma declarativa através do Terraform para assim podermos usufruir de alguns dos benefícios do IaC, como versionamento, automação, performance, idempotencia, ...

Para a infraestrutura da nossa aplicação utlizamos uma série de recursos como: VPC, Internet Gateway, Nat Gateway, Security Groups, ECS, ALB, dentre outros. Para uma melhor entendimento segue um esboço da nossa arquitetura:

<img src="https://i.imgur.com/8GUf5UV.png" width="720" height="800">

Na arquitetura acima contamos com:
- 1 VPC
- 2 Subnets Publicas e 2 Subnets privadas
- 1 internet Gateway
- 2 Nat Gateways
- 1 Routatable publica com saí da para o Internet Gateway
- 2 Route tables privadas com saída para os 2 Nat Gateways
- 1 Taget Group associado às duas Subnets privadas
- 1 Cluster ECS Fargate que provisionará os containers da nossa aplicação nas duas zonas privada
- 1 Application Load Balancer associado as 2 Subnets publicas, recebendo e enviando o trafego recebido para os containers associados ao Target Group.

No codígo Terraform foi aplicado o conceito de módulos reútilizaveis. Tornando nosso codigo, como o proprio nome ja diz,  reutilizável e de fácil personalização, visto que cada recurso desejado é referenciado no arquivo **main.tf** e todos as informações e parâmetros que devem ser fornecidas pelo usuário ficam concentradas em um unico arquivo chamado **variables.tf**.

Caso queira entender a estrutura e organização dos templates Terraform, segue a estrutura:

```bash
.
├── main.tf
├── modules
│   ├── alb_module
│   │   ├── alb.tf
│   │   ├── locals.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecr_module
│   │   ├── ecr.tf
│   │   ├── locals.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecs_module
│   │   ├── auto_scale.tf
│   │   ├── ecs.tf
│   │   ├── iam.tf
│   │   ├── locals.tf
│   │   ├── outputs.tf
│   │   ├── target-group.tf
│   │   └── variables.tf
│   ├── security_groups_module
│   │   ├── locals.tf
│   │   ├── outputs.tf
│   │   ├── security-groups.tf
│   │   └── variables.tf
│   └── vpc_module
│       ├── locals.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── vpc.tf
├── outputs.tf
├── template
│   └── app.json.tpl
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```

## 🏗 GitHub Actions

Para a automação do nosso processo de Deploy tanto da Infraestrutura quanto da aplicação utilizamos o GitHub Actions. Através de seus Workflows de Integração e Entrega Contínua foi possivel integrar elementos chaves entre os dois procedimentos de deploy. Visto que para fazer o deploy da aplicação necessitamos que primeiro sejam criado os componentes de infraestrutura. 

Dessa forma o nosso primeiro workflow em questão. Declarado no arquivo **.github/workflows/workflow_complete.yml**. Cria toda a nossa infraestrutura na AWS e exporta como variável de ambiente informações importantes para o deploy da aplicação como: a url do repositório ECR para que bossamos fazer o push da imagem docker após o processo de build, os nomes do cluster ECS e do service para que possamos enviar a ordem de novo deploy ao Cluster ECS.

Assim o Job que faz o build da aplicação consegue herdar do Job do Terraform as informações que precisa para pazer o Deploy da aplicação no Cluster ECS.

O nosso segundo workflow declarado no arquivo **.github/workflows/workflow_validate_and_plan_code.yml** tem como objetivo Validar a intregridade do codigo terraform a cada novo commit enviado ao reposítório. Dessa forma pode-se ver se o codigo Terraform não possui nenhum erro de syntax e podemos conferir todos os recurso que serão ou não criados em caso de execução do Workflow que faz o Deploy completo da Stack.

Por fim mas não menos importante temos o nosso Workflow de destroy, declarado no arquvo **.github/workflows/workflow_destroy.yml**. Que como o proprio nome sugere, ao ser executado, destroi todos os recursos provisionados na Cloud da AWS.

Dessa forma podemos, além de validar nosso código a cada commit enviado e conferir quais recurso de infraestrutura serão criados antes de excutar o Workflow de deploy. Ter a possibilidade de criar e destruir toda a nossa Stack com um clique.

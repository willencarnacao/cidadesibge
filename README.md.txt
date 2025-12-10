🏙️ Município CSV Processor — Delphi VCL

Este projeto foi desenvolvido em Delphi (VCL Forms Application) para realizar o processamento de um arquivo CSV contendo nomes de municípios e população informada, realizando validação e enriquecimento dos dados através da API pública do IBGE.

O foco principal da solução é segurança na validação dos dados, evitando falsos positivos e matches incorretos.

✅ Funcionalidades

Leitura de arquivos CSV

Normalização de textos (remoção de acentos e tratamento de caixa)

Integração com a API do IBGE

Geração de arquivo CSV de saída

Classificação dos registros em:

OK

AMBIGUO

NAO_ENCONTRADO

🔍 Lógica de Validação

A aplicação não força correspondência quando existe risco de erro.

A regra adotada foi:

Situação	Resultado
Apenas 1 município compatível	OK
Mais de 1 município compatível	AMBIGUO
Nenhum município compatível	NAO_ENCONTRADO

Essa abordagem prioriza integridade de dados ao invés de suposições, garantindo maior confiabilidade no processamento.

🧩 Estrutura do Projeto
/Projeto
 ├── MainForm.pas
 ├── view/
 │   └── uMainForm.pas
 ├── controller/
 │   ├── uCsvController.pas
 │   ├── uIbgeController.pas
 │   ├── uStatsController.pas
 │   └── uSubmitController.pas
 ├── model/
 │   └── uMunicipio.pas
 └── utils/
     └── uStringHelper.pas

📄 Formato do CSV de Entrada
municipio_input,populacao_input
Niteroi,515317
Sao Goncalo,1091737
...

📄 Formato do CSV de Saída
municipio_input,populacao_input,municipio_ibge,uf,regiao,id_ibge,status
Niteroi,515317,Niterói,RJ,Sudeste,3303302,OK
Sao Gonçalo,1091737,,,,,AMBIGUO
...

⚙️ Tecnologias Utilizadas

Delphi (VCL)

System.JSON

System.Net.HttpClient

Consumo de API REST pública do IBGE

🎯 Decisões Técnicas Importantes

Não foram utilizadas bibliotecas externas para manter compatibilidade máxima com o Delphi stock.

Preferência por segurança de dados em vez de heurísticas arriscadas.

Implementação manual de normalização de strings.

▶️ Como Executar

Abrir o projeto no Delphi

Compilar o projeto

Selecionar um arquivo CSV

Clicar em Processar

O arquivo de saída é gerado automaticamente

📌 Observação

O projeto foi desenvolvido com foco em clareza de código, separação por camadas (view/controller/model) e fácil leitura por avaliadores técnicos.
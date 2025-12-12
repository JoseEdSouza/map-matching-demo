# Map matching demo usando GraphHopper + `mmlib` para alinhar trajetórias GPS a uma malha viária

## Passo a passo rápido 🚀

1) Clone: `git clone <repo> && cd map-matching-demo` ✅
2) Instale dependências: `uv sync`
3) Execute `1_download_network.ipynb` para baixar/exportar a rede OSM (pule se já existir) 🌐
4) Configure o GraphHopper: `sh 2_setup_graphhopper.sh` ⚙️
5) Execute `3_map_matching.ipynb` para rodar o map matching com os dados em `data/` 🗺️

## Propósito

- Baixar/exportar uma rede OSM, importar no GraphHopper e expor um serviço local.
- Rodar map matching de trajetórias GPS contra essa rede via `mmlib.graphhopper_matcher`.
- Servir de referência rápida para quem quer testar GraphHopper + map matching.

## Pré-requisitos

- Python 3.13 instalado.
- [uv](https://docs.astral.sh/uv/getting-started/installation/) para gerenciar o ambiente Python.
  > **Nota Didática:** Usamos `uv` por ser um gerenciador de pacotes extremamente rápido e moderno (escrito em Rust), substituindo o fluxo tradicional de `pip` e `virtualenv` com muito mais performance.

- [Docker](https://docs.docker.com/get-started/) e Docker Compose (para subir o GraphHopper).
- [`make`](https://www.gnu.org/software/make/) (opcional, só para facilitar os comandos do GraphHopper).

## Ambiente Python

Na raiz do repositório:

```bash
# cria a .venv e instala tudo de acordo com o uv.lock
uv sync

# opcional: ativar a venv
source .venv/bin/activate
# ou rode comandos sem ativar
uv run python -c "import mmlib; print('ok')"
```

## Dados

- `data/trajectories.parquet`: medições GPS.
- `data/ground_truth.parquet`: referência de verdade-terreno.
- `networks/ohare_network.osm.xml`: rede viária usada pelo GraphHopper. Se quiser gerar novamente, rode o notebook `1_download_network.ipynb` (usa OSMnx para exportar o XML).

## GraphHopper

O serviço ([GraphHopper](https://www.graphhopper.com/)) roda na porta `8989` e precisa do grafo importado a partir do XML em `networks/`.

```bash
# importa o grafo (usa Docker; precisa do arquivo em networks/)
make setup-graphhopper

# sobe o servidor
make run-graphhopper
# ou: docker compose up graphhopper
```

Depois de iniciado, o GraphHopper fica acessível em `http://localhost:8989`.

> **Troubleshooting:** Se o container não subir ou der erro de porta, verifique se a porta `8989` já não está em uso por outro serviço. Você pode checar seus containers ativos com `docker ps`.

❗ Dica, se quiser configurar do zero, use o script `2_setup_graphhopper.sh`,  que já faz tudo automaticamente (importa o grafo baixado e sobe o servidor).

## Notebooks

1. `1_download_network.ipynb`: baixa/exporta a rede OSM para `networks/ohare_network.osm.xml` (pule se já existir).
2. `3_map_matching.ipynb`: carrega os dados de `data/` e chama o matcher via `mmlib.graphhopper_matcher`, assumindo o GraphHopper rodando em `http://localhost:8989`.

Sugestão de comando para abrir:

```bash
uv run jupyter lab
# ou
uv run jupyter notebook
```

## Estrutura

- `docker-compose.yaml`: serviço GraphHopper pronto para uso.
- `graphhopper/config/config.yaml`: ajustes de perfil e importação.
- `graphhopper/setup.sh`: script que importa o grafo OSM para o volume local do GraphHopper.
- `data/`: datasets Parquet usados no notebook de matching.
- `tools/`: utilitários auxiliares.

# Map matching demo usando GraphHopper + `mmlib` para alinhar trajetórias GPS a uma malha viária

## Passo a passo rápido 🚀

1) Clone: `git clone <repo> && cd map-matching-demo` ✅
2) Instale dependências: `uv sync`
3) (Opcional) Ative a venv: `source .venv/bin/activate`
4) Importe o grafo: `make setup-graphhopper` (usa `networks/ohare_network.osm.xml`)
5) Suba o GraphHopper: `make run-graphhopper` (API em `http://localhost:8989`)
6) Abra Jupyter: `uv run jupyter lab`
7) Execute `2_map_matching.ipynb` para rodar o map matching com os dados em `data/` 🗺️

## Propósito

- Baixar/exportar uma rede OSM, importar no GraphHopper e expor um serviço local.
- Rodar map matching de trajetórias GPS contra essa rede via `mmlib.graphhopper_matcher`.
- Servir de referência rápida para quem quer testar GraphHopper + map matching.

## Pré-requisitos

- Python 3.13 instalado.
- [uv](https://docs.astral.sh/uv/getting-started/installation/) para gerenciar o ambiente Python.
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

## Notebooks

1. `1_download_network.ipynb`: baixa/exporta a rede OSM para `networks/ohare_network.osm.xml` (pule se já existir).
2. `2_map_matching.ipynb`: carrega os dados de `data/` e chama o matcher via `mmlib.graphhopper_matcher`, assumindo o GraphHopper rodando em `http://localhost:8989`.

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

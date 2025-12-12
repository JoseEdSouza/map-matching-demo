#!/bin/sh

# Script de Configuração Inicial do GraphHopper
#
# Fluxo de execução:
# 1. Configura 'set -e' para abortar em caso de erro.
# 2. Exibe alerta sobre a reinicialização do setup e perda de dados anteriores.
# 3. Solicita confirmação explícita do usuário (y/n).
# 4. Executa 'make setup-graphhopper' para realizar a importação/preparação dos dados.
# 5. Finaliza executando 'make run-graphhopper' para subir o servidor.

set -e

echo "WARNING: This script erases any current setup of GraphHopper! If you alredy have a GraphHopper setup, abort then just run 'make run-graphhopper' instead."

read -p "Do you want to continue? (y/n) " choice
if [ "$choice" != "y" ]; then
    echo "Aborting setup."
    exit 1
fi

echo "Setting up GraphHopper..."

make setup-graphhopper

echo "GraphHopper setup completed."

make run-graphhopper
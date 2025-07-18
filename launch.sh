#!/bin/bash

show_menu() {
    clear
    echo "==================================="
    echo "       AI Stack Launcher"
    echo "==================================="
    echo ""
    echo "Select your hardware configuration:"
    echo ""
    echo "1. AMD GPU (Windows) - CPU optimized for Windows"
    echo "2. AMD GPU (Linux) - ROCm for Linux AMD GPUs"
    echo "3. NVIDIA GPU - For NVIDIA GeForce/Tesla cards"
    echo "4. CPU Only - No GPU acceleration"
    echo "5. Stop AI Stack"
    echo "6. Exit"
    echo ""
}

while true; do
    show_menu
    read -p "Enter your choice (1-6): " choice
    
    case $choice in
        1)
            echo "Starting with AMD GPU support (Windows - CPU optimized)..."
            echo "NOTE: This is optimized for Windows. Use option 2 for Linux ROCm."
            docker-compose -f docker-compose.yml -f docker-compose.amd-windows.yml up -d
            read -p "Press Enter to continue..."
            ;;
        2)
            echo "Starting with AMD GPU support (Linux - ROCm)..."
            ./scripts/start-amd.sh
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "Starting with NVIDIA GPU support..."
            ./scripts/start-nvidia.sh
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "Starting with CPU-only support..."
            ./scripts/start-cpu.sh
            read -p "Press Enter to continue..."
            ;;
        5)
            echo "Stopping AI Stack..."
            ./scripts/stop.sh
            read -p "Press Enter to continue..."
            ;;
        6)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done

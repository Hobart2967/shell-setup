# --- WSL2 GPU ACCELERATION CONFIG (RTX 4060 Ti) ---

# OpenGL Treiber-Overrides auf D3D12 erzwingen
export GALLIUM_DRIVER=d3d12
export MESA_LOADER_DRIVER_OVERRIDE=d3d12

# Vulkan Treiber-Override auf die Microsoft Dozen-Schicht (dzn) lenken
export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/dzn_icd.json

# Mesa Shader-Cache aktivieren (verhindert Micro-Stuttering in Godot)
export MESA_GLSL_CACHE_DISABLE=0
export MESA_GLSL_CACHE_DIR=~/.cache/mesa_shader_cache

# Cache-Ordner sicherstellen
mkdir -p ~/.cache/mesa_shader_cache

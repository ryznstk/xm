#!/bin/bash

# Vendor (fresh clone)
echo "Cloning vendor tree..."
rm -rf vendor/xiaomi/peridot
git clone -b los https://gitlab.com/blu96/vendor-xiaomi-peridot-qpr-2.git vendor/xiaomi/peridot

# Kernel source (fresh clone)
echo "Cloning kernel source tree..."
rm -rf kernel/xiaomi/sm8635
git clone -b susfs --depth 1 https://gitlab.com/blu96/kernel_xiaomi_sm8635.git kernel/xiaomi/sm8635

rm -rf kernel/xiaomi/sm8635-modules
git clone -b nonkpo --depth 1 https://gitlab.com/blu96/android_kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules

rm -rf kernel/xiaomi/sm8635-devicetrees
git clone -b lineage-23.2 --depth 1 https://github.com/ryznstk/android_kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees

# Setup KernelSU-Next
echo "Setting up KernelSU-Next..."
pushd kernel/xiaomi/sm8635
curl -LSs "https://raw.githubusercontent.com/KernelSU-Next/KernelSU-Next/next/kernel/setup.sh" | bash -
popd

# Hardware xiaomi (fresh clone)
echo "Cloning hardware xiaomi source..."
rm -rf hardware/xiaomi
git clone -b dolby https://github.com/ryznstk/hardware_xiaomi.git hardware/xiaomi

rm -rf packages/apps/XiaomiDolby

rm -rf packages/apps/KProfiles

# MiuiCamera device tree (fresh clone)
echo "Cloning MiuiCamera device tree..."
rm -rf device/xiaomi/peridot-miuicamera
git clone https://github.com/sm8635-dev/device_xiaomi_peridot-miuicamera.git device/xiaomi/peridot-miuicamera

# MiuiCamera vendor tree (fresh clone)
echo "Cloning MiuiCamera vendor tree..."
rm -rf vendor/xiaomi/peridot-miuicamera
git clone https://github.com/sm8635-dev/vendor_xiaomi_peridot-miuicamera.git vendor/xiaomi/peridot-miuicamera

# Gamebar
echo "Cloning Gamebar tree..."
rm -rf packages/apps/GameBar
git clone https://github.com/droidcore/packages_apps_GameBar.git packages/apps/GameBar

# LMO
echo "Cloning LMOfreeroam tree..."
rm -rf packages/apps/LMOFreeform
git clone https://github.com/ryznstk/packages_apps_LMOFreeforms.git packages/apps/LMOFreeform

rm -rf packages/apps/DepthWallpaperHelper

cd system/sepolicy
git fetch https://github.com/ryznstk/lunaris_system_sepolicy.git test
git reset --hard FETCH_HEAD
croot

cd build/soong
git fetch https://github.com/ryznstk/build_soong 16.2
git reset --hard FETCH_HEAD
croot

cd device/lineage/sepolicy
git fetch https://github.com/Lunaris-AOSP/device_lineage_sepolicy test
git reset --hard FETCH_HEAD
croot

cd frameworks/av
git fetch https://github.com/Lunaris-AOSP/frameworks_av test
git reset --hard FETCH_HEAD
croot

cd frameworks/base
git fetch https://github.com/Lunaris-AOSP/frameworks_base test
git reset --hard FETCH_HEAD
croot

cd packages/apps/Launcher3
git fetch https://github.com/Lunaris-AOSP/packages_apps_Launcher3 test
git reset --hard FETCH_HEAD
croot

cd packages/apps/Settings
git fetch https://github.com/ryznstk/packages_apps_Settings test
git reset --hard FETCH_HEAD
croot

cd packages/apps/Singularity
git fetch https://github.com/Lunaris-AOSP/packages_apps_Singularity test
git reset --hard FETCH_HEAD
croot

cd system/core
git fetch https://github.com/Lunaris-AOSP/system_core test
git reset --hard FETCH_HEAD
croot

cd vendor/lineage
git fetch https://github.com/Lunaris-AOSP/vendor_lineage test
git reset --hard FETCH_HEAD
croot

cd vendor/extras
git fetch https://github.com/Lunaris-AOSP/vendor_extras test
git reset --hard FETCH_HEAD
croot

cd device/qcom/sepolicy_vndr/sm8650
git fetch https://github.com/LineageOS/android_device_qcom_sepolicy_vndr.git lineage-23.2-caf-sm8650
git reset --hard FETCH_HEAD
croot

cd hardware/qcom-caf/common
git fetch https://github.com/ryznstk/android_hardware_qcom-caf_common lineage-23.2
git reset --hard FETCH_HEAD
croot

# Refresh signing keys
if [ -d vendor/lineage-priv/keys ]; then
  echo "Removing existing signing keys..."
  rm -rf vendor/lineage-priv/keys
fi
echo "Cloning fresh signing keys..."
git clone https://github.com/droidcore/private_key.git -b main vendor/lineage-priv/keys

# Always back to root at the end
if command -v croot &>/dev/null; then
  croot
else
  cd "$ANDROID_BUILD_TOP" || true
fi

echo "vendorsetup.sh execution complete."

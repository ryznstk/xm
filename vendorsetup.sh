#!/bin/bash

# Vendor (fresh clone)
echo "Cloning vendor tree..."
rm -rf vendor/xiaomi/peridot
git clone -b lk https://gitlab.com/blu96/proprietary-vendor-xiaomi-perid-0-t.git vendor/xiaomi/peridot

# Kernel source (fresh clone)
echo "Cloning kernel source tree..."
rm -rf kernel/xiaomi/sm8635
git clone -b test --depth 1 https://github.com/ryznstk/kernel_xiaomi_sm8635.git kernel/xiaomi/sm8635

rm -rf kernel/xiaomi/sm8635-modules
git clone -b lineage-23.2 --depth 1 https://github.com/ryznstk/kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules

rm -rf kernel/xiaomi/sm8635-devicetrees
git clone -b lineage-23.2 --depth 1 https://github.com/ryznstk/kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees

# Hardware xiaomi (fresh clone)
echo "Cloning hardware xiaomi source..."
rm -rf hardware/xiaomi
git clone -b lineage-23.2 https://github.com/ryznstk/hardware_xiaomi_los.git hardware/xiaomi

rm -rf packages/apps/XiaomiDolby

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
git clone https://github.com/ryznstk/packages_apps_GameBar.git packages/apps/GameBar

rm -rf packages/apps/XiaomiParts

# ViperFX
rm -rf packages/apps/ViPER4AndroidFX
git clone https://github.com/TogoFire/packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX

git clone https://github.com/AxionAOSP/android_packages_apps_AxionFx.git packages/apps/AxionFX

# LMO
echo "fetching LMOfreeroam tree..."
cd packages/apps/LMOFreeform
git fetch https://github.com/kenway214/packages_apps_LMOFreeform.git sixteen-qpr2
git reset --hard FETCH_HEAD
croot

# KProfiles (fresh clone)
echo "Cloning KProfiles..."
rm -rf packages/apps/KProfiles
git clone https://github.com/ryznstk/packages_apps_KProfiles.git packages/apps/KProfiles

#cd system/sepolicy
#git fetch https://github.com/ryznstk/system_sepolicy.git bq2
#git reset --hard FETCH_HEAD
#croot

#cd frameworks/base
#git fetch https://github.com/ryznstk/evo_frameworks_base.git bq2
#git reset --hard FETCH_HEAD
#croot

#cd packages/apps/Evolver
#git fetch https://github.com/ryznstk/packages_apps_Evolver.git bq2
#git reset --hard FETCH_HEAD
#croot

cd device/qcom/sepolicy_vndr/sm8650
git fetch https://github.com/LineageOS/android_device_qcom_sepolicy_vndr.git lineage-23.2-caf-sm8650
git reset --hard FETCH_HEAD
croot

cd hardware/qcom-caf/common
git fetch https://github.com/LineageOS/android_hardware_qcom-caf_common lineage-23.2
git reset --hard FETCH_HEAD
croot

rm -rf vendor/lineage-priv

# Refresh signing keys
if [ -d vendor/evolution-priv/keys ]; then
  echo "Removing existing signing keys..."
  rm -rf vendor/evolution-priv/keys
fi
echo "Cloning fresh signing keys..."
git clone https://github.com/droidcore/private_key.git -b evo vendor/evolution-priv/keys

# Always back to root at the end
if command -v croot &>/dev/null; then
  croot
else
  cd "$ANDROID_BUILD_TOP" || true
fi

echo "vendorsetup.sh execution complete."

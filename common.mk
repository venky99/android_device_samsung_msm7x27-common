# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## SAMSUNG_BOOTLOADER is the product model changed into appropriate string parsed by init.
## Example: -GT-I5500 becomes gt-i5500board, -GT-S5830 becomes gt-s5830board, and so on.
SAMSUNG_BOOTLOADER := $(shell echo $(PRODUCT_VERSION_DEVICE_SPECIFIC)board | tr '[A-Z]' '[a-z]' | cut -c 2-)

## BlueZ support
## Note: needs to be defined here in order to satisfy inheritance issues.
## If disabled, Bluedroid will be used.
BOARD_HAVE_BLUETOOTH_BLUEZ := true

## Audio
PRODUCT_PACKAGES += \
    audio_policy.msm7x27 \
    audio.primary.msm7x27

ifdef BOARD_HAVE_BLUETOOTH_BLUEZ
## BlueZ: binaries
PRODUCT_PACKAGES += \
    bluetoothd \
    brcm_patchram_plus \
    libbluetoothd \
    hcitool \
    hciconfig \
    hciattach

## BlueZ: configs
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/ramdisk/init.msm7x27.bluez.rc:root/init.$(SAMSUNG_BOOTLOADER).bluetooth.rc \
    system/bluetooth/data/audio.conf:system/etc/bluetooth/audio.conf \
    system/bluetooth/data/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    system/bluetooth/data/blacklist.conf:system/etc/bluetooth/blacklist.conf \
    system/bluetooth/data/input.conf:system/etc/bluetooth/input.conf \
    system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf \
    system/bluetooth/data/network.conf:system/etc/bluetooth/network.conf \
    system/bluetooth/data/stack.conf:system/etc/bluetooth/stack.conf

## BlueZ: javax.btobex is required by Bluetooth_msm
PRODUCT_PACKAGES += \
    javax.btobex

## BlueZ: properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.bluetooth.stack=bluez \
    ro.qualcomm.bluetooth.dun=true \
    ro.qualcomm.bluetooth.ftp=true \
    ro.qualcomm.bluetooth.hfp=true \
    ro.qualcomm.bluetooth.hsp=true \
    ro.qualcomm.bluetooth.map=true \
    ro.qualcomm.bluetooth.nap=true \
    ro.qualcomm.bluetooth.opp=true \
    ro.qualcomm.bluetooth.pbap=true \
    ro.qualcomm.bluetooth.sap=true

## FM Radio
PRODUCT_PACKAGES += \
    Effem \
    libfmradio.bcm2049

## FM Radio permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/com.stericsson.hardware.fm.receiver.xml:system/etc/permissions/com.stericsson.hardware.fm.receiver.xml

else

# Bluedroid: configs
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/ramdisk/init.msm7x27.bluedroid.rc:root/init.$(SAMSUNG_BOOTLOADER).bluetooth.rc

endif

## Camera
PRODUCT_PACKAGES += \
    camera.msm7x27 \
    libcamera

## GPS
PRODUCT_PACKAGES += \
    gps.msm7x27 \
    librpc

## HW Composer
PRODUCT_PACKAGES += \
    hwcomposer.msm7x27

## Other
PRODUCT_PACKAGES += \
    lights.msm7x27 \
    power.msm7x27 \
    make_ext4fs \
    brcm_patchram_plus \
    setup_fs

## Vold config
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/etc/vold.fstab:system/etc/vold.fstab

## Hardware properties
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

## Wi-Fi & networking
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/msm7x27-common/prebuilt/etc/wifi/hostapd.conf:system/etc/wifi/hostapd.conf \
    device/samsung/msm7x27-common/prebuilt/bin/get_macaddrs:system/bin/get_macaddrs

## Media
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    device/samsung/msm7x27-common/prebuilt/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/samsung/msm7x27-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/samsung/msm7x27-common/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf \
    device/samsung/msm7x27-common/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

## Keymap
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/msm7x27-common/prebuilt/usr/keylayout/sec_key.kl:system/usr/keylayout/sec_key.kl

## Keychar
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/usr/keylayout/qwerty.kcm:system/usr/keylayout/qwerty.kcm \
    device/samsung/msm7x27-common/prebuilt/usr/keylayout/qwerty2.kcm:system/usr/keylayout/qwerty2.kcm \
    device/samsung/msm7x27-common/prebuilt/usr/keylayout/Virtual.kcm:system/usr/keylayout/Virtual.kcm \
    device/samsung/msm7x27-common/prebuilt/usr/keylayout/Generic.kcm:system/usr/keylayout/Generic.kcm

## Touchscreen
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/usr/idc/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc

# GPS conf
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/prebuilt/etc/gps.conf:system/etc/gps.conf

## Ramdisk
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27-common/ramdisk/init.msm7x27.rc:root/init.$(SAMSUNG_BOOTLOADER).rc \
    device/samsung/msm7x27-common/ramdisk/init.msm7x27.parts.rc:root/init.$(SAMSUNG_BOOTLOADER).parts.rc \
    device/samsung/msm7x27-common/ramdisk/init.msm7x27.usb.rc:root/init.$(SAMSUNG_BOOTLOADER).usb.rc \
    device/samsung/msm7x27-common/ramdisk/ueventd.msm7x27.rc:root/ueventd.$(SAMSUNG_BOOTLOADER).rc

### BEGIN: Common properties

## Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=0 \
    dalvik.vm.debug.alloc=0 \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.dexopt-flags=v=a,o=v,m=y,u=y

## Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    debug.composition.type=mdp \
    debug.sf.no_hw_vsync=0

## Loop ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.call_ring.delay=3000 \
    ro.telephony.call_ring.multiple=false

## Other
PRODUCT_PROPERTY_OVERRIDES += \
    DEVICE_PROVISIONED=1 \
    dev.sfbootcomplete=0 \
    ro.config.play.bootsound=0 \
    ro.setupwizard.enable_bypass=1

## RIL, telephony
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=pdp0,gprs,ppp0 \
    rild.libargs=-d/dev/smd0 \
    rild.libpath=/system/lib/libsec-ril.so \
    ro.telephony.default_network=0 \
    ro.telephony.ril_class=SamsungMSMRIL

## USB
PRODUCT_PROPERTY_OVERRIDES += \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mass_storage,adb

## WiFi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.ap.interface=athap0 \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=180

### END: Common properties

# Inherit qcom/msm7x27
$(call inherit-product, device/qcom/msm7x27/msm7x27.mk)

# Install/Uninstall google apps
$(call inherit-product, vendor/google/gapps_armv6_tiny.mk)

# Common assets
PRODUCT_AAPT_CONFIG := ldpi mdpi normal

# Samsung msm7x27-common overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/msm7x27-common/overlay

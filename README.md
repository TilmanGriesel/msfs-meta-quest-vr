# MSFS Meta Quest VR Helper

This script is designed to get the best VR performance out of Microsoft Flight Simulator (MSFS) in once click when using a Meta Quest headset. It tweaks some key settings to strike a balance between smooth visuals and optimal performance. It is also great as a component for automated setups.

### Here's what it does:

**Locks the headset frame rate to 45 FPS:**
This might sound low, but trust me, it’s a sweet spot for MSFS. It keeps things stable and avoids unnecessary stutters, which is crucial for an immersive flight experience.

**Disables Asynchronous Spacewarp (ASW):**
ASW is a cool feature in theory, it smooths things out when your system struggles but in MSFS, it often adds weird artifacts and makes the visuals feel less natural. Turning it off might feel a bit less smooth, but the overall experience is more realistic and less distracting.

**Sets your desktop resolution to 800x600:**
Why? Because you don’t need your desktop hogging GPU power when you're in VR. Dropping the resolution frees up resources for the game, and it just works well on my setup. I believe it is not absolutely prooven that this improves performance but I have a good experience with this setup.

For me, these settings have made a huge difference in how MSFS runs in VR. If your system is similar, you might just hit that same sweet spot :)

---

### My system specifications

- CPU: AMD Ryzen 7 7700 (8-Core)
- GPU: NVIDIA GeForce RTX 4070
- Memory: 64GB @ 6000 MT/s
- Headset: Meta Quest 2

---

## Setup instructions

### 1. Download and place QRes

QRes is an hold tool that provides Windows resolution changes via CLI paramters.

- Download **QRes** from [MajorGeeks](https://www.majorgeeks.com/files/details/qres.html).
- Place the `QRes.exe` file in the bin folder.

### 2. Configure Meta Quest Link

- **Refresh rate:** Set to **80Hz** or higher.
- **Render resolution:** Configure to **4192 x 2144** for optimal performance, if your rig is stronger then mine, you can probably go a bit higher.

### 3. Adjust Oculus Debug Tool settings

- **Link sharpening:** Set to **Disabled**.
  - This setting will make the output appear slightly blurrier but more realistic, enabling finer control through in-game settings.
  - Disabling sharpening provides a perceptually better overall result.
- **Encode Bitrate:** Optionally set to **400**. Some report that this is a good thing to do, I have mine at 0 and no issues.

---

## **Running the Script**

1. **Run with PowerShell**
   - Open PowerShell and execute the script.
   - You can customize the script using the following options:

| Option                           | Description                      | Default Value                 |
| -------------------------------- | -------------------------------- | ----------------------------- |
| `-o, --oculus-tool <path>`       | Path to `OculusDebugToolCLI.exe` | `$DEFAULT_OCULUS_TOOL`        |
| `-l, --log-file <path>`          | Path to the log file             | `$DEFAULT_LOG_FILE`           |
| `-q, --qres-tool <path>`         | Path to `QRes.exe`               | `$DEFAULT_QRES_TOOL`          |
| `-v, --vr-resolution <res>`      | VR resolution                    | `$DEFAULT_VR_RESOLUTION`      |
| `-d, --default-resolution <res>` | Default resolution               | `$DEFAULT_DEFAULT_RESOLUTION` |

2. **Example command**
   ```powershell
   ./setup-msfs-quest-vr.ps1 -o "path\to\OculusDebugToolCLI.exe" -q "path\to\QRes.exe" -v "1024x768" -d "1920x1080"
   ```

---

### **Notes**

- Ensure all paths and resolutions are configured correctly for your specific setup.
- Experiment with the settings to find the best balance between performance and visual quality.

---

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/yellow_img.png)](https://www.buymeacoffee.com/griesel)

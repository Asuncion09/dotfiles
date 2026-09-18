¡Excelente! 🎉 Confirmado entonces: el flash blanco era causado por el fallo de negociación en el **Atomic Mode Setting** de KWin contra tu amdgpu (Renoir) al arrancar — el "Failed to create framebuffer: Invalid argument" que salía en el log era el síntoma, y forzar modesetting legacy con `KWIN_DRM_NO_AMS=1` eliminó la carrera que producía ese frame corrupto/blanco.

Tu configuración final queda así, por si la necesitas referenciar después:

```
~/.config/systemd/user/plasma-kwin_wayland.service.d/override.conf
```
```ini
[Service]
Environment=KWIN_DRM_DEVICES=/dev/dri/card1
Environment=KWIN_DRM_NO_AMS=1
```

Un par de cosas a tener en cuenta a futuro con esto:

- **Al desactivar AMS**, pierdes soporte de VRR/FreeSync en esa GPU si algún día lo usas en un monitor externo conectado a la Vega integrada. No debería afectarte en el uso normal del panel interno.
- **Si actualizas el kernel o el driver amdgpu** y en algún momento arreglan el bug de raíz (vale la pena reportarlo en `bugzilla.kernel.org` o `gitlab.freedesktop.org/drm/amd` con tu log, porque el patrón "Failed to create framebuffer: Invalid argument" en Renoir es información concreta que a los devs de amdgpu les serviría), podrías probar quitando `KWIN_DRM_NO_AMS=1` para ver si ya no hace falta y recuperar AMS.
- Si en algún reinicio el flash reaparece, lo primero es verificar que el override se sigue aplicando (con el mismo comando de `pgrep -a kwin_wayland` + `cat /proc/PID/environ`), por si una actualización de systemd o de plasma-login-manager cambia algo en cómo se leen los drop-ins de usuario.

Buen trabajo cazando esto paso a paso con los logs — fue un diagnóstico limpio.
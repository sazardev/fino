# Fino — DESIGN.md

Reglas de diseño de **Fino** (app de finanzas para llevar deudas entre
compañeros de trabajo). La UI se copia del sistema de diseño de **Enfo**
(`/home/omar/personal/enfo`, carpeta `lib/ui/`): Material 3 Expressive nativo
de Android, redondo, "gordito", con movimiento por resortes y feedback háptico.

> Este documento define **solo UI/UX**: tokens, componentes, movimiento y
> patrones. La lógica de negocio de Enfo (pomodoro, relojes, alarmas, modos…)
> **no** se copia. Todo lo que aparece de Fino (deudores, montos, abonos) son
> ejemplos de cómo aplicar el sistema, no especificación funcional.

Diferencias deliberadas respecto a Enfo:

| Tema | Enfo | Fino |
| --- | --- | --- |
| Tipografía | Geist **Mono** en todo | **Geist** (sans) en todo; Geist Mono solo para cifras si se quiere (ver §4) |
| Acento por defecto | `Colors.lime` | A elegir; propuesta `0xFF10B981` (emerald, ya está en la paleta de Enfo) |
| Contenido | Relojes y timers | Listas, montos, personas, movimientos |
| Navegación | Controles flotantes, sin menú | **Barra de navegación inferior** (rail lateral en pantallas anchas); **sin AppBar** |
| Plataformas | Android, Windows, Linux | **Móvil, tablet y web** con la misma UI, adaptada por ancho |

---

## 0. Reglas innegociables

Tres reglas que ganan sobre cualquier otra sección de este documento.

### 0.1 Cero tolerancia a AppBar y títulos innecesarios

- **Prohibido** `AppBar`, `SliverAppBar`, `appTopBar` y cualquier barra
  superior. No hay excepciones "por costumbre".
- El destino activo ya se nombra en la navegación: **no se repite como
  título**. "Inicio" sobre Inicio, "Ajustes" sobre Ajustes y "Detalle" sobre
  un detalle sobran.
- Un título solo existe si **aporta algo que la pantalla no dice sola**, y
  entonces es *contenido*, no cromo: `headlineSmall` / `titleMedium` dentro
  del scroll, sin barra ni fondo, y se va con el scroll. Válidos: el nombre de
  la persona en su detalle, "Nuevo movimiento" en un formulario.
- **Prueba:** tapa el título con el dedo. Si la pantalla se entiende igual,
  bórralo.
- **Volver atrás** en una pantalla secundaria: `AppIconButton`
  (`arrow_back_rounded`) flotando arriba a la izquierda sobre el contenido, o
  el gesto/botón del sistema. **Lo decide la ruta, no la pantalla ni el
  navegador:** una pantalla secundaria *siempre* lleva el botón y una raíz de
  destino *nunca*, igual en móvil, tablet y web (nada de preguntar
  `Navigator.canPop()` al construir: se queda desactualizado al redimensionar o
  cambiar de destino). El botón sube un paso si hay pantalla debajo y, si no
  (enlace directo, recarga en web, notificación), va al padre lógico de la ruta. Acciones de contexto (editar, compartir): íconos
  sueltos dentro del contenido, nunca una barra.

### 0.2 Navegación inferior

Los destinos primarios viven en la **barra de navegación inferior**
(`NavigationBar` de Material 3), plana, redonda y animada como el resto.

| Regla | Detalle |
| --- | --- |
| Cantidad | 3 a 5 destinos. Lo demás se esconde dentro de Ajustes |
| Etiquetas | Siempre visibles, **una palabra** ("Inicio", "Deudores", "Ajustes") |
| Estilo | `elevation 0`, sin tint ni sombra, fondo `surfaceContainer`, indicador en **píldora `primary`**, ícono activo `onPrimary`, inactivo `onSurfaceVariant`, etiqueta activa `w600` |
| Íconos | `*_rounded` dibujados con `ChubbyIcon`; el activo hace `IconPop` y háptico `select` |
| Estado | Cada destino conserva su estado (scroll, formulario a medias) al cambiar: `IndexedStack`, no se reconstruye |
| Transición | Fade + escala 0.96 → 1 (`AppCurves.gentle`, `AppDurations.medium`), igual que `appPageRoute` |
| Tocar un destino | Siempre aterriza en su **raíz**: las subpantallas que quedaron abiertas se cierran (Ajustes → Apariencia → Inicio → Ajustes muestra Ajustes, sin botón de volver). La raíz conserva su estado (scroll, formulario). Reseleccionar el activo hace lo mismo. *Subir al inicio del scroll: pendiente* |
| Acción primaria | **Una sola** por pantalla: FAB plano (píldora `primary`/`onPrimary`, `elevation 0`, `BouncyTap`), flotando sobre la barra, alineado al final. En rail va en su slot `leading` |
| Subpantallas | Cada destino tiene su **propia pila de navegación** (`DestinationNavigator`): un detalle se abre *dentro* del destino y la navegación permanece visible; el gesto atrás del sistema cierra primero esa pila. Formularios de captura: pantalla completa sobre la navegación (no compiten con el teclado) |

### 0.3 Responsive siempre: móvil · tablet · web

Una sola app. La navegación y el layout se deciden por **ancho de ventana**,
**nunca por plataforma**: web en una ventana angosta es móvil; una tablet en
split-screen es móvil; un teléfono en landscape ancho es tablet.

| Ancho | `FormFactor` | Navegación | Contenido |
| --- | --- | --- | --- |
| < 600 dp | `compact` | `NavigationBar` **inferior** | 1 columna, ancho completo, padding 20 |
| 600 – 840 dp | `medium` | `NavigationRail` **compacto** a la izquierda (ícono + etiqueta debajo) | Columna centrada de 620 dp |
| ≥ 840 dp | `expanded` | `NavigationRail` **extendido** (ícono + etiqueta al lado) | Master-detail donde haya lista + detalle; columna de 720 dp |
| lado corto < 260 dp | `watch` | Barra mínima, **sin etiquetas** | Contenido a lo esencial |

- **Mismos destinos, mismos íconos, mismo estilo** en barra y rail: solo
  cambia la posición. El rail usa el mismo indicador píldora `primary`.
- Al cambiar el tamaño (ventana web, split-screen, rotación) la navegación se
  **transforma en vivo con animación** y conserva destino activo y estado.
- En pantallas anchas el contenido **nunca** va de borde a borde: columna
  centrada con ancho máximo (§6).
- **Web con puntero y teclado de primera clase:** cursor `click` en todo lo
  tocable, halo de foco visible al navegar con Tab, arrastre con mouse y
  trackpad para hacer scroll. Misma UI, sin una "versión web" aparte.
- Objetivos táctiles ≥ 48 dp; todo escala con el tamaño de UI del usuario
  (`UiSize`) y con el texto del sistema.
- Nada se diseña "primero para un tamaño": cada pantalla se prueba en
  watch, móvil, landscape, tablet y desktop/web (§12).

Implementación (un archivo por cosa):

| Archivo | Hace |
| --- | --- |
| `ui/templates/navigation/app_destination.dart` | modelo: ícono + etiqueta |
| `.../app_bottom_bar.dart` | `NavigationBar` (compact, watch sin etiquetas) |
| `.../app_side_rail.dart` | `NavigationRail` compacto ↔ extendido, con slot `leading` para el FAB |
| `.../app_navigation_shell.dart` | elige barra o rail con `Responsive.usesSideNavigation`; recibe `destinations`, `pages`, `index`, `onSelect`, `onReselect`, `fab` |
| `ui/organisms/fade_scale_indexed_stack.dart` | muestra una página (fade + escala) y mantiene vivas las demás |
| `app/shell/destination_navigator.dart` | pila de navegación propia por destino + gesto atrás |

Las páginas sobreviven al cambio barra ↔ rail porque el shell las monta bajo
una `GlobalKey`: redimensionar una ventana web o girar una tablet no pierde
nada (hay un test que lo verifica).

---

## 1. Principios

1. **Material 3 Expressive, pero plano.** `useMaterial3: true`, `ColorScheme.fromSeed`,
   superficies tonales (`surfaceContainerHigh`) en vez de sombras o bordes.
   Sin gradientes, sin sombras, sin elevación, sin ripple. (Única excepción
   permitida: gradientes *funcionales*, como las pistas del selector de color.)
2. **Todo redondo.** Radios grandes (14 / 20 / 28), botones tipo píldora,
   íconos circulares, chips de selección que se vuelven "squircle".
3. **Todo se mueve, con resortes.** El feedback de interacción *es* el
   movimiento: los controles se encogen al presionar y rebotan al soltar.
   Las entradas hacen pop con sobreimpulso y un pequeño giro. Las pantallas
   entran con fade + escala suave.
4. **Personalizable al máximo.** El usuario elige: modo claro/oscuro/sistema,
   color de acento (5 colores + selector HSV/hex propio), tamaño de UI
   (4 niveles), idioma, y qué botones se muestran. Cada cambio se aplica **en
   vivo**, sin "guardar".
5. **Sin modales.** Nada de `AlertDialog`, bottom sheets ni pickers del
   sistema. Las acciones destructivas se **confirman en el mismo lugar**
   (`ConfirmActionRow`); los selectores son inline.
6. **Háptico con vocabulario.** Nadie llama `HapticFeedback` directo: se piden
   eventos con nombre (`tap`, `select`, `confirm`, `toggle`, `warning`…).
7. **Adaptable.** Mismo sistema en móvil, tablet y web: la navegación pasa de
   barra inferior a rail según el ancho, con columna de contenido limitada y
   escala controlada (ver §0.3 y §6).
8. **Respeta "reducir animaciones".** Toda animación se salta o salta al estado
   final si `MediaQuery.disableAnimationsOf(context)` es `true`.

---

## 2. Tokens

### 2.1 Espaciado (`AppSpacing`)

| Token | dp | Uso típico |
| --- | --- | --- |
| `xs` | 4 | separación mínima, entre título y subtítulo grande |
| `sm` | 8 | entre tiles de una lista, padding superior de página |
| `md` | 12 | entre ícono y texto en watch/compact, padding de fila vertical |
| `lg` | 16 | padding interno de tiles y filas |
| `xl` | 20 | padding horizontal de página (base) |
| `xxl` | 24 | padding inferior de página |
| `xxxl` | 32 | separación entre secciones |
| `huge` | 40 | espacios de héroe / estados vacíos |

### 2.2 Radios (`AppRadii`)

| Token | dp | Uso |
| --- | --- | --- |
| `sm` | 14 | badges de ícono, segmentos, campos de texto |
| `md` | 20 | filas, tiles, tarjetas de selección, foco |
| `lg` | 28 | `Card`, superficies grandes |
| `pill` | `StadiumBorder` | botones `Filled`/`Outlined`, íconos, chips |

Prohibido `BorderRadius.circular(n)` suelto: usar siempre el token (la única
excepción son formas que dependen del tamaño, como el squircle del swatch:
`size * 0.32`).

### 2.3 Movimiento (`AppCurves` + `AppDurations` + `SpringCurve`)

Curvas de resorte de forma cerrada (oscilador amortiguado). Son `Curve`, así
que valen para `AnimatedContainer`, `TweenAnimationBuilder`, `CurvedAnimation`.

| Preset | masa / rigidez / amortiguación | Sobreimpulso | Uso |
| --- | --- | --- | --- |
| `AppCurves.bouncy` | 0.5 / 300 / 8 | ~34 % | taps, pops, celebraciones |
| `AppCurves.snappy` | 1 / 400 / 18 | ~21 % | movimiento general de UI |
| `AppCurves.gentle` | 2 / 150 / 20 | ~11 % | superficies grandes, transición de página |

Presets en `AppCurves` (`bouncy`/`snappy`/`gentle`); duraciones en `AppDurations`: `fast` 150 ms · `medium` 300 ms · `slow` 500 ms.
Curvas estándar de apoyo, también en `AppCurves`: `select` = `easeOut`
(selección, 200–250 ms), `settle` = `easeOutCubic` (`AnimatedSize`),
`emphasized` = `easeOutBack` (cambio de ícono).

> **Trampa:** una curva con sobreimpulso **no** sirve como `curve:` de
> `AnimationController.animateTo()` en un controller 0..1 (lo clampa y se
> vuelve un ease plano). Usarla vía `CurvedAnimation` o un controller
> `.unbounded()`.

### 2.4 Color y tema

- `ColorScheme.fromSeed(seedColor: accent, brightness: …)`; el acento es **un
  `Color` único** (`Themes.accent`) persistido como `int` ARGB.
- Paleta **corta de 5 acentos** (esmeralda —el de por defecto—, azul real,
  violeta, rosa, mandarina) más el selector personalizado HSV + hex. Un acento
  guardado que ya no esté en la paleta se muestra como el personalizado, así
  que reducirla o cambiarla no rompe lo persistido.
- Fondo de pantalla: `colorScheme.surface`. Superficies elevadas
  (tiles, cards, botones secundarios): `surfaceContainerHigh`.
- Seleccionado = `primary` con texto `onPrimary` (subtítulos
  `onPrimary` al 80 %). Texto secundario = `onSurfaceVariant`.
- Íconos de acento: `primary`, sobre badge `primary` al 14 % de alpha.
- Foco de teclado/D-pad: halo `primary` al 22 %, sin borde.
- Destructivo: `colorScheme.error`.
- **Semántica de deuda (UI):** "me deben" y "debo" necesitan dos colores
  distintos, pero **nunca solo por color**: siempre acompañados de signo
  (+/−), ícono o etiqueta. Usar roles del `ColorScheme` (`primary`/`tertiary`
  y `error`), no hex fijos, para que sigan al acento y al modo oscuro.
- `splashFactory: NoSplash.splashFactory`, `highlightColor: transparent`.

### 2.5 Tipografía

- Familia: **Geist** (sans) registrada en `pubspec.yaml` con pesos 400, 500,
  600, 700 (`AppFont.sans`), y aplicada a **todo** el `TextTheme`.
- Construir el `TextTheme` desde un `ThemeData(...)` real y luego
  `.apply(fontFamily: 'Geist')`. **Nunca** desde `Typography.material2021(...)`
  directamente: queda sin color y el texto se vuelve casi invisible.
- Escala (M3 por defecto, estos son los usos):

| Estilo | Uso |
| --- | --- |
| `headlineSmall` | título de panel embebido, encabezados de sección grandes |
| `titleMedium` w600, letterSpacing 0.2 | título de contenido dentro del scroll (solo si aporta, §0.1) |
| `bodyLarge` | título de fila / tile |
| `bodySmall` + `onSurfaceVariant` | subtítulo de fila (2 dp bajo el título) |
| `labelLarge` w600, letterSpacing 0.4 | texto de botones |

- Pesos: 400 cuerpo, 500 apoyo, **600 énfasis**, 700 cifras y valores clave.
- **Cifras de dinero:** usar `FontFeature.tabularFigures()` para que los montos
  no "bailen" al animarse ni al alinearse en columna. Opcional: Geist Mono
  (w600/700) solo para montos grandes si se quiere el carácter de Enfo.
- Texto largo (nombres, notas): `maxLines` + `TextOverflow.ellipsis` en tiles.

### 2.6 Iconos

- Siempre variantes `*_rounded` de Material Icons.
- **`ChubbyIcon`**: el glifo se dibuja dos veces (trazo con `StrokeJoin.round` /
  `StrokeCap.round` de `size * 0.055` detrás + relleno encima) para engordar
  cada borde. Los `Icon` simples dentro de `AppIconButton` se convierten solos.
- Tamaño por defecto 24 × escala de UI; en botones, `size * 0.54`.

---

## 3. Átomos

### `BouncyTap` — el corazón del feedback
Reemplaza ripple/`InkWell`. Envuelve cualquier cosa tappable.
- Al presionar (`onTapDown`): escala a `pressedScale` (0.92 por defecto, **0.98
  filas anchas**, 0.95 tarjetas, 0.88 swatches) en `AppDurations.fast` con
  `easeOut`; háptico `tap` en el mismo instante.
- Al soltar/cancelar: regresa con `AppCurves.bouncy` (rebote).
- Es **focusable** (`FocusableActionDetector`): Enter/OK activa; el foco muestra
  un halo `primary`@22 % (6 dp de margen) y escala 1.05. Pasar
  `focusBorderRadius` igual a la forma del hijo.
- `onLongPress` añade háptico `confirm`. Cursor `click` en desktop.
- Con animaciones reducidas: salta directo al estado presionado/suelto.

### `AppIconButton` — botón de ícono redondo y plano
- Círculo de 44 dp × escala (34 en watch).
- `selected: true` rellena el círculo con `primary` y el ícono pasa a `onPrimary`
  (animado 200 ms `easeOut`).
- **Pop** (620 ms) al tocar y cada vez que `selected` cambia: el ícono se
  aplasta a 0.72 (18 % del tiempo, `easeOut`) y vuelve con `AppCurves.bouncy`
  (82 %), con un bamboleo `sin(t·π·3)·0.16·(1−t)` de rotación.
- `tooltip` obligatorio para accesibilidad en acciones solo-ícono.

### `AppSwitch`
`Switch` M3 + háptico (`toggle(true)` doble rápido rising, `toggle(false)` uno
suave). Thumb `onPrimary`, track `primary` al estar activo. Nunca usar `Switch`
pelado.

### `AccentSwatch`
Círculo de 52 dp, **tamaño fijo** (jamás estirarlo a la celda del grid).
Seleccionado → el círculo **morfa a squircle** (`radius = size·0.32`) y muestra
`check_rounded` con contraste calculado (`estimateBrightnessForColor`).
Selección = cambio de forma, no borde.

### `PopIn`
Entrada one-shot: de `scale 0 → 1` con `AppCurves.bouncy`, rotación inicial −0.35
rad que se endereza, y fade sobre el primer 40 % (560 ms). Acepta `delay`.
Para listas/barras: **escalonar 60 ms por elemento** (`delay: 60ms * i`).

---

## 4. Moléculas

### `SettingsRow`
Fila plana: etiqueta (+ subtítulo) a la izquierda, control a la derecha.
Padding `lg` horizontal / `md` vertical. Si tiene `onTap`: `BouncyTap` (0.98)
con `ClipRRect` `md`. Sin ripple, sin divisores.

### `SettingsNavTile`
Tile que lleva a otra pantalla: fondo `surfaceContainerHigh`, radio `md`,
padding `lg`, **badge de ícono** 40 dp (radio `sm`, fondo `primary`@14 %,
`ChubbyIcon` 55 % del badge), título `bodyLarge`, subtítulo con el valor
actual, chevron `chevron_right_rounded`. Separación vertical `sm`.
`selected` (master-detail en pantallas anchas) → fondo `primary`, todo
`onPrimary`, animado 200 ms. En watch colapsa a ícono + título.

### `SelectableCard` (patrón "tarjeta seleccionable")
`BouncyTap` 0.95 → `AnimatedContainer` 250 ms `easeOut`; no seleccionada
`surfaceContainerHigh`, seleccionada `primary`. Título w600, subtítulo 12 px
en `onSurfaceVariant` (o `onPrimary`@80 %). Radio `md`.

### `ThemeModeSelector`
`SegmentedButton` plano: sin borde, `surfaceContainerHigh` / seleccionado
`primary`+`onPrimary`, `showSelectedIcon: false`, radio `sm`. Sistema / Claro /
Oscuro, se aplica al instante.

### `ConfirmActionRow` (sustituto de los diálogos)
Acción destructiva en dos pasos **en la misma fila**: tap → la fila se
reemplaza por "Confirmar: …" (texto y ícono en `error`) + fila "Cancelar".
Contenedor `AnimatedSize` (`AppDurations.medium`, `easeOutCubic`, `topCenter`).
Háptico `warning` al confirmar; spinner de 20 dp mientras corre.

### Stepper / slider con ±
`AppIconButton` de 36 dp (−/+) a los lados del valor (w700, color de acento) y
debajo un `Slider` con pista de 3 dp, **sin overlay**, un háptico `tick` por
cada paso entero.

### Sin `AppTopBar`
No existe. Ver §0.1. Su lugar lo toman tres piezas pequeñas:

- **`FloatingBackButton`** — `AppIconButton` con flecha dentro de un círculo
  tonal (`surfaceContainerHigh`) para leerse sobre lo que haga scroll debajo.
  `SettingsShell` lo muestra solo si recibe `onBack` (la ruta se lo da con
  `BackNavigation.to`) y lo alinea con el borde izquierdo de la columna de
  contenido.
- **`ScreenTitle`** — título *de contenido* (`headlineSmall` w700): primer
  elemento del scroll, solo cuando aporta (§0.1).
- **`AppFab`** — la acción primaria: píldora `primary` plana, `BouncyTap` 0.94,
  háptico `confirm`. Muestra su etiqueta solo en `expanded`; en el resto,
  solo el ícono con tooltip.

### Secciones contraíbles (`CollapsibleSection`)
Tarjeta `surfaceContainer` (radio `lg`) con encabezado — `IconBadge`, título,
**resumen del valor actual** (solo plegada, máx. 120 dp; oculto en watch) y
chevron que gira — y cuerpo que se pliega con `AnimatedSize` (`medium`,
`settle`).

### Estilos rápidos (`PresetPicker` + `PresetTile` + `ThemePreview`)
Looks listos (`AppearancePreset`): **tema + color** que combinan — Esmeralda,
Océano, Medianoche, Rosé, Atardecer, Bosque. **No tocan el tamaño de UI**, que
es personal y tiene su propio control; la sección lo dice en una línea.
**Lista vertical** (una fila por estilo; dos columnas desde 520 dp de ancho,
nunca rejilla en móvil). Cada fila lleva un **mini preview** del app en ese look
y con el tamaño actual del usuario (`ThemePreview`: superficie, tarjeta con
botón de acento y barra de navegación; el modo Sistema se parte en diagonal
claro/oscuro), el nombre, qué hace ("Oscuro · Violeta") y un check. La fila
seleccionada se llena con `primary`; si tema y color no coinciden con ninguno,
la sección dice "Personalizado".

### Pantalla Apariencia
Secciones contraíbles, en este orden: **Estilo rápido** (abierta), **Color de
acento**, **Tema**, **Tamaño de la interfaz** (cada una con su valor como
resumen) y al final **Restablecer apariencia** (confirma en sitio). Tamaño
explica cada opción en una línea y ofrece "Ampliar en pantallas grandes".

### Selector de color inline (`AccentPicker` + `ColorPickerPanel`)
`Wrap` centrado de 5 swatches de 44 dp (+ swatch "personalizado") → al elegir custom se
despliega con `AnimatedSize` (`medium`, `easeOutCubic`) un panel con sliders
de Hue/Sat/Brillo sobre pistas con gradiente y un campo hex (`#`, 6 chars,
solo `[0-9a-fA-F]`). HSV es la fuente de verdad (RGB perdería el matiz en
sat/brillo 0).

---

## 5. Plantillas y navegación

### Transición de página (`appPageRoute`)
`PageRouteBuilder`, 300 ms: `FadeTransition` + `ScaleTransition` 0.96 → 1 con
`AppCurves.gentle`. **No** usar `FadeThrough`/`SharedAxis`/`MaterialPageRoute`:
rellenan con una caja sólida de `canvasColor` que se ve como un destello feo
contra un acento vivo. Toda navegación pasa por `appPageRoute`.

### `SettingsShell` (pantalla con secciones desplazables)
`Scaffold` **sin AppBar** + `SafeArea` + scroll con padding
`(pagePadding, sm, pagePadding, xxl)`; el contenido va centrado en una columna
con ancho máximo adaptable (`contentWidth`). Si la pantalla necesita título
(§0.1) es el primer elemento del scroll (`headlineSmall`); si es una
subpantalla, lleva el botón de volver flotante. Mientras `loaded == false`, un
`CircularProgressIndicator` centrado.

### Hub en dos paneles *(pendiente de implementar)*
< 840 dp: lista de `SettingsNavTile` que empuja pantallas. ≥ 840 dp:
master-detail (lista a la izquierda, detalle a la derecha con
`AnimatedSwitcher`, `AppDurations.medium`).

### Splash animado
~2.6 s, tap para saltar: la marca es una **"F" caligráfica de pluma
puntiaguda** que se **escribe a sí misma** con un `CustomPainter`
(`FinoMarkPainter`). Cada trazo se pre-muestrea una vez y su grosor sigue la
presión de la pluma: hairline (0.7) al subir o ir de lado, se ensancha (4.2) al
bajar, con entradas y salidas afiladas. Guion: remate superior
(`easeInOutSine`) → levantada → fuste con rizo (`easeInOutCubic`) → gota de
tinta al final del rizo (`AppCurves.bouncy`) → travesaño. Una copia difusa al
18 % debajo simula tinta sobre papel. Luego el nombre (w400, tracking 10) sube
10 dp con fade (`Interval 0.66–0.92`). Cierra con
`pushReplacement(appPageRoute(...))`. Con animaciones reducidas muestra el
logo final. La tinta sigue el acento (`primary`).

### Onboarding
Wizard de pasos donde **cada elección se aplica en vivo** (idioma, tema, acento,
tamaño). Cambios de altura con `AnimatedSize` (`medium`, `easeOutCubic`);
entradas escalonadas con `Interval(a, b, curve: easeOutCubic)`.

---

## 6. Responsive (`Responsive.of(context)`)

| FormFactor | Condición | Navegación | Notas |
| --- | --- | --- | --- |
| `watch` | lado corto < 260 dp | barra mínima sin etiquetas | UI mínima; escala 1.0; padding 10 |
| `compact` | ancho < 600 | `NavigationBar` inferior | móvil vertical, web angosta |
| `medium` | 600–840 | rail compacto | móvil horizontal, tablet chica |
| `expanded` | ≥ 840 | rail extendido | tablet, desktop, web ancha; master-detail |

- `scale = uiSize.multiplier` (`UiSize`: small 0.9 · normal 1.0 · large 1.25 ·
  extraLarge 1.5). **El tamaño elegido se respeta tal cual en toda pantalla**:
  S es S en móvil, tablet y desktop. Solo si el usuario activa "Ampliar en
  pantallas grandes" (`adaptToScreen`, apagado por defecto) se multiplica
  además por `clamp(shortestSide / 480, 1.0, 1.5)`. Texto e íconos se
  multiplican por `scale` en el `builder` de `MaterialApp`
  (`TextScaler.linear(systemScale × scale)` + `IconTheme.merge`).
- Ancho de contenido: 480 (compact) / 620 (medium) / 720 (expanded) × scale,
  nunca más que la ventana. Pantallas densas pueden usar 90 % del ancho en
  `expanded`.
- Padding de página: `20 × min(scale, 1.3)` (10 en watch).
- `isWide`: ancho ≥ 600 y relación de aspecto > 1.15 → layout lado a lado.
- Diseñar y probar overflow en: watch, teléfono, landscape, tablet, desktop.

---

## 7. Háptica

Un solo vocabulario de eventos (`Haptics.*`), configurable por el usuario
(maestro on/off, intensidad suave/media/fuerte, categorías):

`tap` (press-down, ligero) · `select` · `confirm` (decisión, más firme) ·
`toggle(on)` · `tick` (un paso de slider/rueda) · `dragStart` / `drop` ·
`transition` · `warning` (destructivo) · `success`.

Regla de dos fases como un botón físico: **presionar = toque ligero; decidir =
golpe más firme**. Los eventos diminutos se *debounce* a 22 ms para que una
rueda rápida no se vuelva zumbido. Solo móviles vibran; en desktop se oculta el
ajuste. Usar `AppSwitch`, no `Switch`.

---

## 8. Accesibilidad

- Todo control interactivo debe ser alcanzable por teclado/D-pad (`BouncyTap`
  ya lo es) y tener `tooltip`/`Semantics` si es solo ícono.
- Objetivos táctiles ≥ 44 dp × escala (36 mínimo cuando el espacio obliga).
- Contraste: texto sobre `primary` siempre `onPrimary`; sobre swatches, el
  contraste se calcula con `estimateBrightnessForColor`.
- No transmitir información solo con color (deuda a favor/en contra: signo +
  ícono).
- `disableAnimations` respetado en `BouncyTap`, `AppIconButton`, `PopIn`,
  splash y transiciones.
- Tamaño de UI y escala de texto del sistema se **multiplican**, no compiten.

---

## 9. Mapa de Fino sobre el sistema (propuesta de UI)

Solo para orientar el uso de componentes; la funcionalidad se define aparte.
Destinos de ejemplo (3–5, una palabra): **Inicio · Deudores · Historial ·
Ajustes**. Ninguna pantalla lleva AppBar.

| Pantalla | Componentes del sistema |
| --- | --- |
| Inicio | Resumen grande y centrado dentro de la columna; sin título (la barra ya dice "Inicio"); FAB plano "nuevo movimiento" |
| Deudores | Lista de filas estilo `SettingsNavTile`: badge circular con inicial, nombre `bodyLarge`, subtítulo (último movimiento), monto `w700` con cifras tabulares; `BouncyTap` 0.98; entrada escalonada con `PopIn`. En `expanded`: master-detail (lista + detalle) |
| Detalle de deudor | Botón de volver flotante; el **nombre de la persona** como título en el scroll (aporta información); tarjetas `lg`; movimientos con `SettingsRow` |
| Agregar / editar | Pantalla completa sin navegación; título en el scroll; campos con el `InputDecorationTheme` del tema, stepper ± para montos, chips `SelectableCard`; guardar como acción primaria |
| Eliminar / borrar todo | `ConfirmActionRow` (sin diálogo) |
| Ajustes | Lista de `SettingsNavTile`: Apariencia, Idioma, Vibración, Datos. Sin título "Ajustes" repetido |
| Estado vacío | `ChubbyIcon` grande + texto; el ícono entra con `PopIn` |
| Carga | `CircularProgressIndicator` centrado (único spinner del sistema) |

---

## 10. Arquitectura y estructura de carpetas

**Regla de oro: un archivo hace una sola cosa.** Ningún archivo de `lib/`
pasa de 150 líneas (lo verifica un test); si crece, se parte. Un widget por archivo, un token por
archivo, un componente de tema por archivo.

```
lib/
  main.dart                     arranque: cargar ajustes, enlazar háptica, runApp
  app/                          composición de la app (la única capa que conoce a todas)
    fino_app.dart               MaterialApp + tema + escala responsive
    settings/                   AppSettings, SettingsScope, hub y pantalla Apariencia
    shell/                      AppShell (destinos) · DestinationNavigator · can_pop_observer
    splash/  home/              pantallas (home incluye el formulario de ejemplo)
    gallery/                    galería de componentes (+ sections/, una por archivo)
  core/                         sin UI, sin dependencias de ui/
    haptics/                    HapticEngine (interfaz) · SystemHapticEngine · Haptics · haptics_binding
    preferences/                PersistedValue<T> · codecs/ (value, bool, color, enum)
    utils/                      reduced_motion · color_contrast
  ui/                           el sistema de diseño (no conoce a app/)
    design/                     tokens: app_spacing · app_radii · app_durations
                                · spring_curve · app_curves · app_font
    responsive/                 form_factor · ui_size · ui_size_scope · responsive
                                · responsive_scaler · app_layout
    theme/                      accent_palette · app_color_scheme · app_text_theme
                                · tabular_text · app_theme
      components/               un *_component_theme.dart por componente Material
                                (incluye navigation_bar y navigation_rail; sin app_bar)
    atoms/                      bouncy_tap · focus_halo · chubby_icon · icon_pop
                                · app_icon_button · app_switch
                                · accent_swatch · pop_in · icon_badge
    molecules/                  settings_row · settings_nav_tile · selectable_card
                                · section_header · empty_state · value_stepper
                                · gradient_slider · hex_field · color_picker_panel
                                · custom_accent_swatch · flat_segmented_button
                                · theme_mode_selector · ui_size_selector
                                · confirm_action_row · switching_icon_button
                                · app_fab · floating_back_button · screen_title
    organisms/                  accent_picker · fade_scale_indexed_stack
    templates/                  settings_shell · navigation/ (app_destination,
                                app_bottom_bar, app_side_rail, app_navigation_shell)
    navigation/                 app_page_route
    brand/                      fino_mark · fino_mark_painter
```

### Dirección de dependencias (nunca al revés)

```
app  →  ui  →  core        (ui y core no importan app/)
templates → organisms → molecules → atoms → design / responsive / theme
```

Un átomo no importa moléculas; un organismo no importa plantillas; `core/`
no importa `ui/`. Las pantallas de `app/` solo componen.

### SOLID aplicado

- **S** — una responsabilidad por archivo: `BouncyTap` solo anima el press;
  el halo de foco es `FocusHalo`; el rebote del ícono es `IconPop`; la
  persistencia es `PersistedValue`; cómo se serializa un valor es un `ValueCodec`.
- **O** — se extiende sin tocar lo existente: un tipo nuevo de ajuste es un
  `ValueCodec` nuevo; un componente de tema nuevo es un archivo nuevo en
  `theme/components/` y una línea en `AppTheme`; un acento nuevo se **agrega
  al final** de `AccentPalette`.
- **L** — cualquier `HapticEngine` sustituye a `SystemHapticEngine` (los tests
  usan uno falso); cualquier `ValueCodec<T>` sirve a `PersistedValue<T>`.
- **I** — interfaces mínimas: `HapticEngine` son 4 métodos; `ValueCodec` son 2.
- **D** — se depende de abstracciones inyectadas, no de globales:
  `PersistedValue` recibe `SharedPreferences`; `Responsive.of` lee el tamaño de
  UI de `UiSizeScope`, no de un singleton; las pantallas leen ajustes de
  `SettingsScope`. (Única estática deliberada: la fachada `Haptics`, cuyo
  motor es reemplazable.)

### Cómo agregar…

| Quiero… | Hago… |
| --- | --- |
| un ajuste nuevo | `PersistedValue` en `AppSettings` (+ codec si es un tipo nuevo) |
| un componente | un archivo en la capa atómica que le toca; si necesita otro widget, ese va en su propio archivo |
| un componente Material con tema propio | `theme/components/x_component_theme.dart` + registrarlo en `app_theme.dart` |
| una pantalla de ajustes | `SettingsShell` + `SettingsNavTile` en `settings_page.dart` |
| una sección en la galería | un archivo en `app/gallery/sections/` + una línea en `gallery_page.dart` |

---

## 11. Setup y estado actual

- Fuentes: `assets/fonts/Geist-*.ttf` y `GeistMono-*.ttf` (400/500/600/700,
  licencia OFL incluida), registradas en `pubspec.yaml` como `Geist` y `GeistMono`.
- Única dependencia añadida: `shared_preferences`. El modo claro/oscuro y el
  acento los resuelve `AppSettings` + `ThemeMode` de Flutter (no se usa
  `adaptive_theme`).
- Los textos de UI están en español dentro de los widgets. **Pendiente:**
  l10n con ARB (el checklist lo exige cuando el idioma sea configurable).
- **Pendiente:** subir al inicio del scroll al reseleccionar el destino activo
  (hoy solo vuelve a la raíz); el gesto atrás en la raíz de un destino que no
  es el primero sale de la app en vez de volver a Inicio.
- **Deuda de tamaño:** `fino_mark_painter.dart` (el logo "F" caligráfico)
  pasa de 150 líneas; falta separar `PenStroke` en su propio archivo. Está en
  la lista `oversize` de `design_rules_test.dart`: vaciarla al partir el archivo.
- **Pendiente:** hub de ajustes en dos paneles (master-detail ≥ 840 dp) y
  háptica compuesta con `vibration` (hoy solo `HapticFeedback` del sistema).
- Tests (`flutter test`):
  - tokens y curvas, persistencia de ajustes, `BouncyTap` (escala + háptica);
  - **`design_rules_test`**: escanea `lib/` y falla ante `AppBar`, `appBar:`,
    diálogos, bottom sheets, `InkWell`, sombras o `HapticFeedback` directo, y
    ante archivos de más de 150 líneas;
  - **navegación**: barra vs rail por ancho (incluye móvil en landscape),
    cero AppBar en cada destino y tamaño, el destino no se repite como título,
    estado conservado entre destinos y al redimensionar, subpantallas con la
    navegación visible, volver flotante y gesto atrás, FAB;
  - una **matriz de responsive** que recorre cada destino, una subpantalla y el
    formulario en watch / móvil / landscape / medium / tablet / desktop / web
    ancho × UI small / extraLarge y falla ante cualquier overflow.
  Se carga Geist real con `FontLoader` (la fuente de test, Ahem, es mucho más
  ancha y reporta overflows falsos).
- Verificación visual sin pantalla: `matchesGoldenFile` con `--update-goldens`
  y mirar el PNG (los íconos Material salen como cajas; en la app real no).

## 12. Checklist de revisión (para cada pantalla/PR)

- [ ] ¿**Cero AppBar**? ¿Algún título repite lo que ya dice la navegación? (prueba del dedo, §0.1)
- [ ] ¿La navegación es `NavigationBar` en compact y rail en medium/expanded, decidida por ancho?
- [ ] ¿Hay una sola acción primaria y las subpantallas tienen volver flotante?
- [ ] ¿Usa solo tokens (`AppSpacing`, `AppRadii`, `AppCurves`, `AppDurations`) y roles del `ColorScheme`?
- [ ] ¿Cero sombras, bordes, gradientes decorativos, ripple, diálogos y sheets?
- [ ] ¿Todo lo tappable pasa por `BouncyTap` (o `AppIconButton`)?
- [ ] ¿Los íconos son `*_rounded` y, en botones, `ChubbyIcon`?
- [ ] ¿La selección se expresa con relleno `primary` o morph de forma?
- [ ] ¿Las entradas usan `PopIn` escalonado y la navegación `appPageRoute`?
- [ ] ¿Respeta `disableAnimations`?
- [ ] ¿Los montos usan cifras tabulares y la deuda no depende solo del color?
- [ ] ¿Probado sin overflow en watch / teléfono / landscape / tablet / desktop-web y en `UiSize.extraLarge`, y al redimensionar en vivo conserva destino y estado?
- [ ] ¿Los eventos hápticos vienen del vocabulario `Haptics.*`?
- [ ] ¿Todo texto visible sale de l10n (no strings sueltos)?

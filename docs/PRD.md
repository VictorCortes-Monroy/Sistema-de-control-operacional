# PRD – Sistema de Control de Asistencia Operacional (Turnos 10x10)

## 1. Información General

**Nombre del producto:**
Sistema de Control de Asistencia Operacional (SCAO)

**Área solicitante:**
Operaciones / RRHH / Administración de Contratos

**Tipo de producto:**
Sistema interno de gestión operativa (Web + Móvil)

**Estado:**
Definición inicial – PRD v1.0

## 2. Contexto y Problema

La empresa opera como prestadora de servicios logísticos intensivos en mano de obra, bajo un esquema de turnos 10x10 en faena.
La continuidad operacional depende directamente de la disponibilidad real de trabajadores.

**Problema actual**
- El control de asistencia es manual, fragmentado y desfasado
- No existe una fuente única de verdad
- Las decisiones se toman con información incompleta o tardía
- Alto riesgo operativo, contractual y laboral

**Consecuencia directa**
La empresa no sabe con certeza quién está realmente disponible para operar hoy ni en los próximos días.

## 3. Objetivo del Producto

**Objetivo principal**
Disponer de un sistema que permita visualizar y controlar en forma actualizada (casi en tiempo real) la asistencia y disponibilidad operativa de los trabajadores bajo turnos 10x10.

**Objetivos secundarios**
- Reducir errores humanos en la gestión de turnos
- Aumentar trazabilidad y control laboral
- Facilitar la planificación operativa diaria
- Disminuir riesgos legales y contractuales

## 4. Alcance del Producto

**Incluye**
- Gestión de trabajadores y turnos 10x10
- Registro y visualización de asistencia diaria
- Gestión de estados laborales (licencias, permisos, vacaciones)
- Dashboard operativo por turno
- Roles y permisos por tipo de usuario

**No incluye (por ahora)**
- Cálculo de remuneraciones
- Integración con ERP de sueldos
- Control biométrico avanzado (se evalúa en fases posteriores)

## 5. Usuarios y Roles

### 5.1 Operaciones
- Visualiza dotación disponible
- Detecta brechas operativas
- Toma decisiones diarias

### 5.2 Supervisores
- Reportan asistencia
- Justifican ausencias
- Informan permisos

### 5.3 RRHH
- Cargan licencias médicas
- Registran vacaciones
- Mantienen condiciones laborales

### 5.4 Jefatura / Gerencia
- Visualiza indicadores
- Evalúa riesgos
- Analiza tendencias

## 6. Definición de Entidades Clave

### 6.1 Trabajador
**Campos mínimos:**
- ID trabajador (único)
- Nombre
- Turno asignado (A / B)
- Día de turno (1 a 10)
- Estado diario
- Sindicato (sí / no)
- Observaciones

### 6.2 Turno
- **Tipo:** A o B
- **Ciclo:** 10 días
- **Fecha inicio**
- **Fecha término**
- **Estado:** (activo / inactivo)

### 6.3 Estado diario del trabajador
**Estados mutuamente excluyentes:**
- Presente
- Ausente injustificado
- Permiso autorizado
- Licencia médica
- Vacaciones

## 7. Reglas de Negocio (CRÍTICAS)
- Un trabajador solo puede tener un estado por día
- Si está en licencia médica → no puede marcar asistencia
- Si está de vacaciones → no puede marcar asistencia
- Permiso autorizado ≠ ausencia
- Un trabajador solo puede marcar asistencia en su turno activo
- El ciclo 10x10 se reinicia automáticamente
- Todo cambio debe quedar trazado (usuario + fecha)

## 8. Funcionalidades Principales

### 8.1 Gestión de asistencia
- Registro diario de asistencia
- Carga manual validada por supervisor
- Visualización por turno y día

### 8.2 Gestión de estados laborales
- Registro de licencias médicas
- Registro de vacaciones
- Registro de permisos

### 8.3 Visualización operativa
- Vista diaria por turno
- Dotación planificada vs real
- Alertar de ausencias críticas

### 8.4 Dashboard de indicadores
- % asistencia por turno
- Ausencias por causa
- Impacto operacional diario
- Tendencias históricas

## 9. Requerimientos No Funcionales
- Alta confiabilidad
- Fácil uso (perfil no técnico)
- Acceso desde faena (móvil)
- Tolerancia a baja conectividad
- Registro de auditoría completo
- Escalable por cantidad de trabajadores

## 10. Métricas de Éxito (KPIs)
- % de asistencia reportada a tiempo
- Reducción de errores de planificación
- Disminución de ausencias no justificadas
- Tiempo promedio de actualización diaria
- Nivel de adopción por supervisores

## 11. Riesgos Identificados
- Resistencia al cambio
- Dependencia de carga manual inicial
- Conectividad en faena
- Calidad de datos en etapa temprana

## 12. Supuestos
- Los turnos A/B están bien definidos
- RRHH dispone de información confiable
- Supervisores tienen acceso móvil
- La empresa prioriza control sobre automatización extrema

## 13. Roadmap sugerido (alto nivel)

**Fase 1 – MVP (0–3 meses)**
- Gestión de trabajadores
- Turnos 10x10
- Asistencia diaria
- Dashboard básico

**Definición de Éxito del MVP**
“Cada mañana la operación sabe exactamente cuántas personas tiene disponibles, en qué estado están y qué riesgos existen para el día.”

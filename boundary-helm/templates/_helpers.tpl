{{/*
Expand the name of the chart.
*/}}
{{- define "boundary.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "boundary.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "boundary.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "boundary.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{ include "boundary.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "boundary.selectorLabels" -}}
app.kubernetes.io/name: {{ include "boundary.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "boundary.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "boundary.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

# the following added by Mehmet

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "boundary.namespace" -}}
{{- default .Release.Namespace .Values.global.namespace -}}
{{- end -}}


# {{/*
# Sets the toleration for pod placement when running in standalone and HA modes.
# */}}
# {{- define "boundary.tolerations" -}}
#   {{- if and (ne .mode "dev") .Values.server.tolerations }}
#       tolerations:
#       {{- $tp := typeOf .Values.server.tolerations }}
#       {{- if eq $tp "string" }}
#         {{ tpl .Values.server.tolerations . | nindent 8 | trim }}
#       {{- else }}
#         {{- toYaml .Values.server.tolerations | nindent 8 }}
#       {{- end }}
#   {{- end }}
# {{- end -}}

{{/*
Inject extra environment populated by secrets, if populated
*/}}
{{- define "boundary.extraSecretEnvironmentVars" -}}
{{- if .extraSecretEnvironmentVars -}}
{{- range .extraSecretEnvironmentVars }}
- name: {{ .envName }}
  valueFrom:
    secretKeyRef:
      name: {{ .secretName }}
      key: {{ .secretKey }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Convert Vault KV v2 logical path to API path
Injects /data/ into the path (e.g., secret/database/postgres -> secret/data/database/postgres)
Usage: {{ include "boundary.vaultSecretPath" . }}
*/}}
{{- define "boundary.vaultSecretPath" -}}
{{- $parts := splitList "/" .Values.vault.databaseSecretPath -}}
{{- if ge (len $parts) 2 -}}
{{- $mount := index $parts 0 -}}
{{- $rest := slice $parts 1 | join "/" -}}
{{- printf "%s/data/%s" $mount $rest -}}
{{- else -}}
{{- .Values.vault.databaseSecretPath -}}
{{- end -}}
{{- end -}}

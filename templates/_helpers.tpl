{{/*
Return true if an auth secret object should be created
*/}}
{{- define "livebook.auth.createSecret" -}}
{{- if .Values.auth.existingSecret -}}
{{- else -}}
  {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a clustering secret object should be created
*/}}
{{- define "livebook.clustering.createSecret" -}}
{{- if .Values.clustering.existingSecret -}}
{{- else -}}
  {{- $existingSecret := (lookup "v1" "Secret" (include "common.names.namespace" .) (printf "%s-clustering" (include "common.names.fullname" .) | trunc 63)).data -}}
  livebookCookie: {{ $existingSecret.livebookCookie | default (.Values.clustering.livebookCookie | default (randAlphaNum 20)) | b64enc}}
{{- end -}}
{{- end -}}

{{/*
Return true if a networking secret object should be created
*/}}
{{- define "livebook.networking.createSecret" -}}
{{- if .Values.networking.existingSecret -}}
{{- else -}}
  {{- $existingSecret := (lookup "v1" "Secret" (include "common.names.namespace" .) (printf "%s-networking" (include "common.names.fullname" .) | trunc 63)).data -}}
  livebookSecretKeyBase: {{ $existingSecret.livebookSecretKeyBase | default (.Values.networking.livebookSecretKeyBase | default (randAlphaNum 48 | b64enc)) | b64enc}}
{{- end -}}
{{- end -}}

{{/*
Return true if a s3 secret object should be created
*/}}
{{- define "livebook.s3.createSecret" -}}
{{- if .Values.s3.existingSecret -}}
{{- else -}}
  {{- true -}}
{{- end -}}
{{- end -}}

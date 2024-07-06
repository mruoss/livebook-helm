{{/*
Return true if an auth secret object should be created
*/}}
{{- define "livebook.auth.createSecret" -}}
{{- if .Values.livebook.auth.existingSecret -}}
{{- else -}}
  {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a clustering secret object should be created
*/}}
{{- define "livebook.clustering.createSecret" -}}
{{- if .Values.livebook.clustering.existingSecret -}}
{{- else -}}
  {{- $existingSecret := (lookup "v1" "Secret" (include "common.names.namespace" .) (printf "%s-clustering" (include "common.names.fullname" .) | trunc 63)).data -}}
  livebookCookie: {{ $existingSecret.livebookCookie | default (.Values.livebook.clustering.livebookCookie | default (randAlphaNum 20)) | b64enc}}
{{- end -}}
{{- end -}}

{{/*
Return true if a networking secret object should be created
*/}}
{{- define "livebook.networking.createSecret" -}}
{{- if .Values.livebook.networking.existingSecret -}}
{{- else -}}
  {{- $existingSecret := (lookup "v1" "Secret" (include "common.names.namespace" .) (printf "%s-networking" (include "common.names.fullname" .) | trunc 63)).data -}}
  livebookSecretKeyBase: {{ $existingSecret.livebookSecretKeyBase | default (.Values.livebook.networking.livebookSecretKeyBase | default (randAlphaNum 48 | b64enc)) | b64enc}}
{{- end -}}
{{- end -}}

{{/*
Return true if a s3 secret object should be created
*/}}
{{- define "livebook.s3.createSecret" -}}
{{- if or (not .Values.livebook.s3.livebookAwsCredentials) .Values.livebook.s3.existingSecret -}}
{{- else -}}
  {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "livebook.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.livebook.image) "context" $) -}}
{{- end -}}

{{/*
Returns the proper service account name depending if an explicit service account name is set
in the values file. If the name is not set it will default to either common.names.fullname if serviceAccount.create
is true or default otherwise.
*/}}
{{- define "livebook.serviceAccountName" -}}
    {{- if .Values.livebook.serviceAccount.create -}}
        {{ default (include "common.names.fullname" .) .Values.livebook.serviceAccount.name }}
    {{- else -}}
        {{ default "default" .Values.livebook.serviceAccount.name }}
    {{- end -}}
{{- end -}}

{{/*
Return the PVC name (only in standalone mode)
*/}}
{{- define "livebook.claimName" -}}
{{- if and .Values.livebook.persistence.existingClaim }}
    {{- printf "%s" (tpl .Values.livebook.persistence.existingClaim $) -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the ingress anotation
*/}}
{{- define "livebook.ingress.annotations" -}}
{{ .Values.livebook.ingress.annotations | toYaml }}
{{- end -}}

{{/*
Return the ingress hostname
*/}}
{{- define "livebook.ingress.hostname" -}}
{{- tpl .Values.livebook.ingress.hostname $ -}}
{{- end -}}
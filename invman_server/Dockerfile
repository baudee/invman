FROM dart:3.7.0 AS build

WORKDIR /app
COPY . .

RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server

FROM alpine:latest

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

COPY --from=build /runtime/ /
COPY --from=build /app/bin/server server
COPY --from=build /app/confi[g]/ config/
COPY --from=build /app/we[b]/ web/
COPY --from=build /app/migration[s]/ migrations/
COPY --from=build /app/.env .env


EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ./server --apply-migrations --apply-repair-migration --mode=$runmode --server-id=$serverid --logging=$logging --role=$role

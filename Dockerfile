FROM mongo:6.0.5
WORKDIR /mongo-seed

COPY ./mongo-seed/ .

RUN chmod +x import.sh

CMD ["sh", "-c", "/mongo-seed/import.sh"]
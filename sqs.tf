variable "queue_names" {
  default = [
    "pedido-criado",
    "pedido-aguardando-pagamento",
    "pedido-pago",
    "pedido-recebido",
    "pedido-em-preparo",
    "pedido-pronto",
    "pedido-finalizado",
    "pedido-cancelado",
    "cozinha-erro-pedido-recebido",
    "cozinha-erro-pedido-em-preparo",
    "cozinha-erro-pedido-pronto",
    "cozinha-erro-pedido-finalizado",
    "pagamento-erro-pedido-cancelar",
    "pagamento-receber-pedido-pago",
    "pagamento-gerar-pagamento",
    "pagamento-erro-pagamento-pedido"
  ]
}

resource "aws_sqs_queue" "queue" {
  count = length(var.queue_names)

  name                      = var.queue_names[count.index]
  delay_seconds             = 0 #Este é o tempo em segundos que a entrega de todas as mensagens na fila será atrasada.
  max_message_size          = 2048 #o tamanho máximo da mensagem em bytes. Mensagens maiores que esse tamanho serão rejeitadas.
  message_retention_seconds = 86400 # o período em segundos durante o qual o Amazon SQS retém uma mensagem.
  receive_wait_time_seconds = 20  # O tempo durante o qual uma Receive Message chamada aguardará a chegada de uma mensagem.
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.queue_dlq[count.index].arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "queue_dlq" {
  count = length(var.queue_names)

  name = "${var.queue_names[count.index]}-dlq"
}

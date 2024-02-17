resource "aws_sqs_queue" "criar_pedido" {
  name   = "criar-pedido"
  delay_seconds             = 0    #Este é o tempo em segundos que a entrega de todas as mensagens na fila será atrasada.
  max_message_size          = 2048  #o tamanho máximo da mensagem em bytes. Mensagens maiores que esse tamanho serão rejeitadas.
  message_retention_seconds = 86400 # o período em segundos durante o qual o Amazon SQS retém uma mensagem.
  receive_wait_time_seconds = 10    # O tempo durante o qual uma Receive Message chamada aguardará a chegada de uma mensagem.
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.criar_pedido_dlq.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "criar_pedido_dlq" {
  name = "criar-pedido-dlq"
}

resource "aws_sqs_queue" "pagamento_pendente" {
  name   = "pagamento-pendente"
  delay_seconds             = 0    #Este é o tempo em segundos que a entrega de todas as mensagens na fila será atrasada.
  max_message_size          = 2048  #o tamanho máximo da mensagem em bytes. Mensagens maiores que esse tamanho serão rejeitadas.
  message_retention_seconds = 86400 # o período em segundos durante o qual o Amazon SQS retém uma mensagem.
  receive_wait_time_seconds = 10    # O tempo durante o qual uma Receive Message chamada aguardará a chegada de uma mensagem.
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.pagamento_pendente_dlq.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "pagamento_pendente_dlq" {
  name = "pagamento-pendente-dlq"
}


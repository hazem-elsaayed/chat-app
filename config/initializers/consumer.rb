consumer_service = ConsumerService.new
consumer_service.consume_message('chat', Chat)
consumer_service.consume_message('message', Message)

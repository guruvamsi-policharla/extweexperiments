all:
	# configure the folder name
	/home/vamsi/dpss-env/bin/python3 -m grpc_tools.protoc --proto_path=. --python_out=. --grpc_python_out=. services.proto

clean:

	rm services_pb2.py
	rm services_pb2_grpc.py

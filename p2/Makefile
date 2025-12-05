.PHONY: all up d provision down halt clean fclean re

VAGRANT := vagrant

all: up

up:
	@$(VAGRANT) up

d:
	@$(VAGRANT) up --provision >/dev/null

provision:
	@$(VAGRANT) provision

status:
	@$(VAGRANT) status

down halt:
	@$(VAGRANT) halt

clean:
	@$(VAGRANT) destroy -f

fclean:
	@$(VAGRANT) destroy -f

re: fclean up


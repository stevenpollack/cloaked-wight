
# use vagrant to test shell scripts -- set the recipe to a PHONY target
.PHONY: test-scripts

test-scripts:
	vagrant destroy -f
	vagrant up --provision
	vagrant destroy -f

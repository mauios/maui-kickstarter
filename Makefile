VERSION = $(shell cat VERSION)
NAME=maui-kickstarter
TAGVER = $(shell cat VERSION | sed -e "s/\([0-9\.]*\).*/\1/")

ifeq ($(VERSION), $(TAGVER))
        TAG = $(TAGVER)
else
        TAG = "HEAD"
endif


PYTHON=python
CHEETAH=cheetah
TEMPLATES=$(wildcard *.tmpl)
TEMPLATE_MODS=$(patsubst %.tmpl,%.py,$(TEMPLATES))
.SECONDARY: $(TEMPLATE_MODS)

all: tmpls
	python setup.py build

tmpls:
	cd kickstart; make

install: build
	$(PYTHON) setup.py install

%.py: %.tmpl
	$(CHEETAH) compile --settings='useStackFrames=False' $<

tag:
	git tag $(VERSION)

dist-bz2:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(TAG) | \
		bzip2  > $(NAME)-$(VERSION).tar.bz2

dist-gz:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(TAG) | \
		gzip  > $(NAME)-$(VERSION).tar.gz

dist: dist-bz2

clean:
	rm -f $(TEMPLATE_MODS)
	rm -f $(addsuffix .bak,$(TEMPLATE_MODS))
	rm -f *.pyc *.pyo
	rm -rf build/ kickstart/kickstart.py kickstart/__init__.py *~ */*~

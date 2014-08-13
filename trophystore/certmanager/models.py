from django.db import models
import ast

class ListField(models.TextField):
    __metaclass__ = models.SubfieldBase
    description = "Stores a python list"

    def __init__(self, *args, **kwargs):
        super(ListField, self).__init__(*args, **kwargs)

    def to_python(self, value):
        if not value:
            value = []

        if isinstance(value, list):
            return value

        return ast.literal_eval(value)

    def get_prep_value(self, value):
        if value is None:
            return value

        return unicode(value)

    def value_to_string(self, obj):
        value = self._get_val_from_obj(obj)
        return self.get_db_prep_value(value)

class Certificate(models.Model):
    validity = models.PositiveSmallIntegerField()
    common_name = models.CharField(max_length=255)
    sans = ListField()
    server_type = models.SmallIntegerField()
    signature_hash = models.CharField(max_length=255)
    org_unit = models.CharField(max_length=255)
    org_name = models.CharField(max_length=255)
    org_addr1 = models.CharField(max_length=255)
    org_addr2 = models.CharField(max_length=255)
    org_city = models.CharField(max_length=255)
    org_state = models.CharField(max_length=255)
    org_zip = models.CharField(max_length=255)
    org_county = models.CharField(max_length=255)
    telephone = models.CharField(max_length=255)
    org_contact_job_title = models.CharField(max_length=255)
    org_contact_firstname = models.CharField(max_length=255)
    org_contact_lastname = models.CharField(max_length=255)
    org_contact_email = models.EmailField()
    org_contact_telephone = models.CharField(max_length=255)
    org_contact_telephone_ext = models.CharField(max_length=255)
    ev = models.BooleanField()

    def __unicode__(self):
        return self.common_name

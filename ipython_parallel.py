# Please check my own question at stack overflow http://stackoverflow.com/questions/34210522/how-to-run-a-custom-script-in-parallel-with-django/34302741#34302741

# pip install ipyparallel -- necessary to run the cluster
# create a file on ~/.ipython/profile_default/startup/00-load_django.py and paste this gist to it: https://gist.github.com/hassek/49956bce9f44d3853b42
# start cluster: ipcluster start -n X --profile=tomtom
# where X is the number of parallel engines desired, a good number is your machines core + 1, so if you have 4 cores, 5 is a good number
# you can now run any functions in parallel from ipython!
# Is very important to notice that anything that is returned should be able to be pickled.
# i.e. list(Receipt.objects.all()) will return but Receipt.obejcts.all() will rise an error

from ipyparallel import Client; rc = Client(); lview = rc.load_balanced_view()

@lview.parallel()
def fix(last_user):
    from mongoengine.base.datastructures import BaseDict
    from receipt.models import Receipt
    fixed_receipts = []
    for rep in Receipt.objects.filter(user_id__gte=last_user, user_id__lt=last_user+1000, tracking__type=3):
        if type(rep.tracking) == BaseDict:
            if '0' in rep.tracking:
                rep.tracking = []
                rep.save()
                fixed_receipts.append((rep.id, "FIXED"))

    return fixed_receipts

res = fix.map(range(0, 10000, 1000))  # This will execute 10 tasks
res.wait_interactive()  # this will show the progress


from datetime import datetime; from shipment.models import Shipment
from ipyparallel import Client; rc = Client(); lview = rc.load_balanced_view()

@lview.parallel()
def fix(ship_range):
    from datetime import datetime; from shipment.models import Shipment
    for shipment in Shipment.objects.filter(delivery_status__nin=Shipment.FINISH_STATUS, created_on__gte=datetime(2015, 11, 1), carrier_name='OnTrac').order_by('-created_on')[ship_range: ship_range + 1000]:
        shipment.update_tracking_number()


ship_count = Shipment.objects.filter(delivery_status__nin=Shipment.FINISH_STATUS, created_on__gte=datetime(2016, 1, 1), carrier_name='USPS').count()
fix.map(range(0, ship_count, 1000))

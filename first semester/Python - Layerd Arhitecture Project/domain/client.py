class Client:
    def __init__(self, _id, name):
        self._id = _id
        self._name = name

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self, new_id):
        self._id = new_id

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, new_name):
        self._name = new_name

    def __eq__(self, z):
        if isinstance(z, Client) is False:
            return False
        if self.id == z.id:
            return True
        else:
            return False

    def __str__(self):
        return "ID: " + str(self._id) + ", Name:" + str(self._name)

    def __repr__(self):
        return str(self)

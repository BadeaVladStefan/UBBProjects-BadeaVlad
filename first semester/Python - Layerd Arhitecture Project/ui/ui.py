from datetime import date


class Ui:
    def __init__(self, client_service, book_service, rental_service):
        self._client_service = client_service
        self._book_service = book_service
        self._rental_service = rental_service

    def show_main_menu(self):
        print()
        print("1.Work on the client or book list")
        print("2.Rent or return a book")
        print("3.Search something in the client list or in the book list")
        print("4.Show statistics")
        print("5.Quit")
        print()

    def run_console(self):
        while True:
            self.show_main_menu()
            big_option = input(">>>")
            if big_option == "1":
                self.option1_menu()
            elif big_option == "2":
                self.option2_menu()
            elif big_option == "3":
                self.option3_menu()
            elif big_option == "4":
                self.option4_menu()
            elif big_option == "5":
                return

    def option3_menu(self):
        print()
        print("In what list are you looking for?")
        print("1.Client list")
        print("2.Book list")
        print()
        option = input(">>>")
        if option == "1":
            text = input("Please enter a text:")
            list = []
            for client in self._client_service._repository.get_all():
                id = str(client.id)
                name = str(client.name)
                if text.lower() in id.lower() or text.lower() in name.lower():
                    list.append(client)
            print(list)
        elif option == "2":
            text = input("Please enter a text:")
            list = []
            for book in self._book_service._repository.get_all():
                id = str(book.id)
                title = str(book.title)
                author = str(book.author)
                if text.lower() in id.lower() or text.lower() in title.lower() or text.lower() in author.lower():
                    list.append(book)
            print(list)

    def option4_menu(self):
        print()
        print("What statistic do you want to see?")
        print("1.Most rented books")
        print("2.Most active clients")
        print("3.Most rented author")
        print()
        option = input(">>>")
        if option == "1":
            print(self._rental_service.most_rented_book())
        elif option == "2":
            print(self._rental_service.most_active_clients())
        elif option == "3":
            print(self._rental_service.most_rented_author())

    def option1_menu(self):
        print()
        print("What do you want to modify?")
        print("1.Client list")
        print("2.Book List")
        print()
        option = input(">>>")
        if option == "1":
            self.modify_client_list()
        if option == "2":
            self.modify_book_list()

    def option2_menu(self):
        print()
        print("1.Create a rental")
        print("2.Remove a rental")
        print("3.Show rental list")
        print()
        option = input(">>>")
        if option == "1":
            try:
                id = input("Enter the id of the rental:")
                book_id = int(input("Enter the id of an existing book:"))
                book = self._book_service._repository.find(int(book_id))

                client_id = input("Enter the id of an existing client:")
                # client_name = input("Enter the name of the client")
                # client = Client(client_id, client_name)

                client = self._client_service._repository.find(int(client_id))

                start_year = int(input("Starting year:"))
                start_month = int(input("Starting month:"))
                start_day = int(input("Starting day:"))

                end_year = int(input("Ending year:"))
                end_month = int(input("Ending month:"))
                end_day = int(input("Ending day:"))

                self._rental_service.create_rental(int(id), client, book, date(start_year, start_month, start_day),
                                                   date(end_year, end_month, end_day))

            except Exception as ex:
                print("Error -", ex)
        elif option == "2":
            try:
                id = int(input("Enter an existing rental:"))
                self._rental_service.delete_rental(id)
            except Exception as ex:
                print("Error -", ex)
        elif option == "3":
            try:
                print("The rentals are:")
                print(self._rental_service.get_all())
            except Exception as ex:
                print("Error -", ex)

    def modify_client_list(self):
        print()
        print("1.Add a client")
        print("2.Remove a client")
        print("3.Update a client")
        print("4.Show client list")
        print()
        option = input(">>>")
        if option == "1":
            try:
                client_id = input("Enter the id of the client:")
                client_name = input("Enter the name of the client:")
                self._client_service.create(int(client_id), client_name)
            except Exception as ex:
                print("Error - ", ex)
        elif option == "2":
            try:
                client_id = input("Enter the id of the client you want to delete:")
                self._client_service.delete(int(client_id))
            except Exception as ex:
                print("Error - ", ex)
        elif option == "3":
            try:
                client_id = input("Enter the id of an existing client")
                client_name = input("Enter the new name of the client")
                self._client_service.update(int(client_id), client_name)
            except Exception as ex:
                print("Error -", ex)
        elif option == "4":
            print("The client list is")
            print(self._client_service.get_all())

    def modify_book_list(self):
        print()
        print("1.Add a book")
        print("2.Remove a book")
        print("3.Update a book")
        print("4.Show book list")
        print()
        option = input(">>>")
        if option == "1":
            try:
                book_id = input("Enter the id of the book:")
                book_title = input("Enter the title of the book:")
                book_author = input("Enter the author of the book:")
                self._book_service.create(book_id, book_title, book_author)
            except Exception as ex:
                print("Error - ", ex)
        elif option == "2":
            try:
                book_id = input("Enter the id of the book:")
                self._book_service.delete(book_id)
            except Exception as ex:
                print("Error -", ex)
        elif option == "3":
            try:
                book_id = input("Enter the id of an existing book:")
                book_title = input("Enter the title of the book:")
                book_author = input("Enter the author of the book:")
                self._book_service.update(book_id, book_title, book_author)
            except Exception as ex:
                print("Error - ", ex)
        elif option == "4":
            print("The book list is")
            print(self._book_service.get_all())

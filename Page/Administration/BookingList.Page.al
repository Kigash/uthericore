page 50990 "Booking List"
{
    // version TL2.0

    CardPageID = "Booking Process Card";
    PageType = List;
    SourceTable = "Booking Process";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(User; Rec.User)
                {
                    ApplicationArea = All;

                }
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    ApplicationArea = All;

                }
                field("Booking Time"; Rec."Booking Time")
                {
                    ApplicationArea = All;

                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;

                }
                field(Resources; Rec.Resources)
                {
                    ApplicationArea = All;

                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;

                }
                field(Book; Rec.Book)
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;

                }
                field("Type of Meeting"; Rec."Type of Meeting")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}


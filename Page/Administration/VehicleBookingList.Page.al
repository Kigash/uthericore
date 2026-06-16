page 51002 "Vehicle Booking List"
{
    // version TL2.0

    CardPageID = "Vehicle Booking Card";
    PageType = List;
    SourceTable = "Vehicle Booking";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Period of Use"; Rec."Period of Use")
                {
                    ApplicationArea = All;
                }
                field("Booking Time"; Rec."Booking Time")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Available Car"; Rec."Available Car")
                {
                    ApplicationArea = All;
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                }
                field(Booked; Rec.Booked)
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                }
                field("Time of Use"; Rec."Time of Use")
                {
                    ApplicationArea = All;
                    Caption = 'Specific time';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    var
        "Vehicle Booking1": Record "Vehicle Booking";
    //User : Record "91";
}


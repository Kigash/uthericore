page 50992 "Booking Card"
{
    // version TL2.0

    Editable = false;
    PageType = Card;
    SourceTable = "Booking Process";

    layout
    {
        area(content)
        {
            group("Book boordroom")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    TableRelation = "Boardroom Detail";
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Booking Time"; Rec."Booking Time")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Caption = 'Meeting Start Date';

                }
                field("Meeting End Date"; Rec."Meeting End Date")
                {
                    ApplicationArea = All;

                }
                field(Resources; Rec.Resources)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;

                }
                field("Specific time of use"; Rec."Specific time of use")
                {
                    Caption = 'Meeting Start Time';
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    Caption = 'Meeting End Time';

                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
                field(Agenda; Agenda)
                {
                    ApplicationArea = All;
                    Caption = 'Meeting Agenda';
                    MultiLine = true;

                }
                field("Type of Meeting"; Rec."Type of Meeting")
                {
                    ApplicationArea = All;

                }
                field("In Attendance"; Rec.Attendees)
                {
                    ApplicationArea = All;
                    Caption = 'In Attendance';

                }
                field("No of Attendees"; Rec."No of Attendees")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Book; Rec.Book)
                {
                    ApplicationArea = All;

                }
            }
            part("Attendees Subform"; "Attendees Subform")
            {
                Caption = 'Attendees Subform';
            }
            part("Boardroom Items Subform"; "Boardroom Items Subform")
            {
                Caption = 'Boardroom Items Subform';
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
            }
            systempart(Notes; Notes)
            {
            }
            systempart(MyNotes; MyNotes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Book Boardroom")
            {
                Image = BookingsLogo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.BookBoardroom(Rec);
                    //CurrPage.CLOSE;
                end;
            }
            action("View Booked Rooms")
            {
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.ViewBookedBoardrooms(Rec);
                end;
            }
        }
    }

    trigger OnInit();
    begin
        Rec."Booking Date" := TODAY;
    end;

    var
        Agenda: Text;
        instr: InStream;
        BookingProcess: Record "Booking Process";
        AdminNoseries: Record "Admin Numbering Setup";
        RegistryManagement: Codeunit "Registry Management2";
}


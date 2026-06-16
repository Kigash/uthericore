page 51005 "Car Booking Card"
{
    // version TL2.0

    Editable = false;
    PageType = Card;
    SourceTable = "Vehicle Booking";

    layout
    {
        area(content)
        {
            group("Vehicle Booking")
            {
                field("No."; Rec."No.")
                {
                }
                field("Available Car"; Rec."Available Car")
                {
                    Caption = 'List of cars';
                    TableRelation = "Vehicle Register";
                    ApplicationArea = All;


                    trigger OnValidate();
                    begin
                        GvVehicle.RESET;
                        GvVehicle.SETRANGE("Number Plate", Rec."Available Car");
                        IF GvVehicle.FIND('-') THEN BEGIN
                            Rec."Branch Code" := GvVehicle."Branch Code";
                        END;
                    end;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;

                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;

                }
                field("Required Date"; Rec."Required Date")
                {
                    Caption = 'Required From Date';
                    ApplicationArea = All;

                }
                field("Required To Date"; Rec."Required To Date")
                {
                    ApplicationArea = All;


                    trigger OnValidate();
                    begin
                        IF Rec."Days use" < '1' THEN BEGIN
                            ShowTime := TRUE;
                        END;
                    end;
                }
                field("Days use"; Rec."Days use")
                {
                    Caption = 'Days Of Use needed';
                    ApplicationArea = All;

                }
                field("Start Time"; Rec."Start Time")
                {
                    Visible = ShowTime;
                    ApplicationArea = All;

                }
                field("End Time"; Rec."End Time")
                {
                    Visible = ShowTime;
                    ApplicationArea = All;

                }
                field("Period of Use"; Rec."Period of Use")
                {
                    Caption = 'Hours Needed';
                    Visible = ShowTime;
                    ApplicationArea = All;

                }
                field("Hourly use"; Rec."Hourly use")
                {
                    Caption = 'Specific time vehicle is needed';
                    Visible = false;
                    ApplicationArea = All;

                }
                field("Time of Use"; Rec."Time of Use")
                {
                    Caption = 'Specific Dates Vehicle is needed';
                    Visible = false;
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Driver Required ?"; Rec."Driver Required ?")
                {
                    Caption = 'Book Driver?';
                    ApplicationArea = All;

                }
                field(User; Rec.User)
                {
                    Caption = 'Booked by';
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Book)
            {
                Image = CalculatePlan;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    AdminManagement.BookVehicle(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        ShowTime := TRUE;
    end;

    var
        GvVehicle: Record "Vehicle Register";
        AdminNoseries: Record "Admin Numbering Setup";
        //CurrentUser : Record "91";
        //Mail : Codeunit "397";
        Employee: Record Employee;
        HODEmail: Text[80];
        //smtpcu : Codeunit "400";
        bdDialog: Dialog;
        //smtpsetup : Record "409";
        mailheader: Text;
        mailbody: Text;
        vehiclebooking: Record "Vehicle Booking";
        //depemails : Record "349";
        ShowTime: Boolean;
        AdminManagement: Codeunit "Admin Management";
}


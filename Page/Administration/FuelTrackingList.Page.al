page 51011 "Fuel Tracking List"
{
    // version TL2.0

    CardPageID = "Fuel Tracking Card";
    PageType = List;
    SourceTable = "Fuel Tracking";

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
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Fuel Receipt Date"; Rec."Fuel Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Fuel Cost"; Rec."Fuel Cost")
                {
                    ApplicationArea = All;
                }
                field("Fueled Litres"; Rec."Fueled Litres")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Rec.Mileage)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Number Plate"; Rec."Vehicle Number Plate")
                {
                    ApplicationArea = All;
                }
                field(Tracked; Rec.Tracked)
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
            action("Print Fuel Mgt Report")
            {

                trigger OnAction();
                begin
                    CLEAR("Fuel Management");
                    "Fuel Tracking".RESET;
                    "Fuel Tracking".SETRANGE("Fuel Cost", Rec."Fuel Cost");
                    IF "Fuel Tracking".FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(51221, TRUE, FALSE, "Fuel Tracking");
                    END;
                end;
            }
        }
    }

    var
        "Fuel Tracking": Record "Fuel Tracking";
        "Fuel Management": Record "Fuel Tracking";
}


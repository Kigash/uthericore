page 51009 "Vehicle Insurance List"
{
    // version TL2.0

    CardPageID = "Vehicle Insurance Card";
    PageType = List;
    SourceTable = "Vehicle Insurance Scheduling";

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
                field("Fixed Asset car No."; Rec."Fixed Asset car No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vehicle Number Plate"; Rec."Vehicle Number Plate")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Designated Driver"; Rec."Designated Driver")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Valuation Date"; Rec."Valuation Date")
                {
                    ApplicationArea = All;
                }
                field(Scheduled; Rec.Scheduled)
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
            action("Print Valuation Details")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.TESTFIELD("Insurance Company");
                    Rec.TESTFIELD("Valuation Date");
                    CLEAR("Vehicle Valuation Scheduling");
                    "Vehicle Insurance Scheduling".RESET;
                    "Vehicle Insurance Scheduling".SETRANGE("Insurance Company", Rec."Insurance Company");
                    IF "Vehicle Insurance Scheduling".FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(51222, TRUE, FALSE, "Vehicle Insurance Scheduling");
                    END;
                end;
            }
        }
    }

    var
        "Vehicle Insurance Scheduling": Record "Vehicle Insurance Scheduling";
        "Vehicle Valuation Scheduling": Record "Vehicle Insurance Scheduling";
}


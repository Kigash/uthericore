page 51010 "Vehicle Insurance Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Vehicle Insurance Scheduling";

    layout
    {
        area(content)
        {
            group("Insurance Scheduling")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Fixed Asset car No."; Rec."Fixed Asset car No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vehicle Number Plate"; Rec."Vehicle Number Plate")
                {
                    ApplicationArea = All;
                    TableRelation = "Vehicle Register";
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Designated Driver"; Rec."Designated Driver")
                {
                    ApplicationArea = All;
                    TableRelation = "Driver Setup";
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Type of Insurance"; Rec."Type of Insurance")
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
                field("Last Valuation Date"; Rec."Last Valuation Date")
                {
                    ApplicationArea = All;
                }
                field("Last Valuation Amount"; Rec."Last Valuation Amount")
                {
                    ApplicationArea = All;
                }
                field("Last Valuer Company"; Rec."Last Valuer Company")
                {
                    ApplicationArea = All;
                }
                field(Scheduled; Rec.Scheduled)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Schedule Insurance Valuation")
            {
                ApplicationArea = all;
                Caption = 'Schedule Valuation';
                Image = Insurance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    AdminManagement.ScheduleInsuranceValuation(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        AdminManagement: Codeunit "Admin Management";
}


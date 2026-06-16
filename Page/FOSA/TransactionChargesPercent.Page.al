page 50023 "Transaction Charges-Percent"
{
    // version TL2.0

    AutoSplitKey = true;
    Caption = 'Percent Charges Subform';
    PageType = ListPart;
    SourceTable = "Transaction Charge";
    SourceTableView = where("Calculation Method" = filter("Based on %"));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = All;
                }
                field("Settlement %"; Rec."Settlement %")
                {
                    ApplicationArea = All;
                }

                field("Settlement % (TL)"; Rec."Settlement % (TL)")
                {
                    ApplicationArea = All;
                }

                field("Settlement % (COOP)"; Rec."Settlement % (COOP)")
                {
                    ApplicationArea = All;
                }
                field("Settlement % (AGENT)"; Rec."Settlement % (AGENT)")
                {
                    ApplicationArea = All;
                }

                field("Total Charge Amount"; Rec."Total Charge Amount")
                {
                    ApplicationArea = All;
                }
                field("Agent Type"; Rec."Agent Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
    end;

    trigger OnOpenPage()
    begin
    end;

    var
}


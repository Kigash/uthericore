page 50168 "Cheque Book"
{
    // version CTS2.0

    PageType = Card;
    SourceTable = "Cheque Book";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("No. of Leaves"; Rec."No. of Leaves")
                {
                    ApplicationArea = All;
                }
                field("Start Leaf No."; Rec."Start Leaf No.")
                {
                    ApplicationArea = All;
                }
                field("End Leaf No."; Rec."End Leaf No.")
                {
                    ApplicationArea = All;
                }
                field("Last Leaf Used"; Rec."Last Leaf Used")
                {
                    ApplicationArea = All;
                    // BlankZero=true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }

            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var

    begin
        SetEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF Rec.Status <> Rec.Status::New THEN
            ERROR('');
    end;

    local procedure SetEditable()
    begin

        IF Rec.Status = Rec.Status::Issued THEN
            CurrPage.EDITABLE := FALSE
        else
            CurrPage.Editable := true;

    end;

}
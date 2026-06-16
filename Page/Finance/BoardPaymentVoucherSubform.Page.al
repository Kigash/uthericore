page 56603 "Board Payment Voucher Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Board Payment Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Account Type"; Rec."Account Type")
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
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }


                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update()
                    end;

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Lines")
            {
                Image = SuggestLines;
                Visible = false;

                trigger OnAction();
                begin
                    //CashManagement.SuggestPaymentLines(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin

    end;

    var
        CashManagement: Codeunit "Cash Management";

}


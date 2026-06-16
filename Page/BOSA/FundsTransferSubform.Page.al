page 56009 "Funds Transfer Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Funds Transfer Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Account Type");
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Account Type");
                    end;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Account Type");
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
                ApplicationArea = all;
                Visible = false;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                begin
                    //CashManagement.SuggestReceiptLines(Rec);
                end;
            }

        }
    }

    trigger OnAfterGetRecord();
    begin

    end;

    procedure SetTransactionType(var TransType: Integer)
    var

    begin
        TransactionType := TransType;
    end;

    var
        //PaymentRemittanceAdvise : Report "50441";
        CashManagement: Codeunit "Cash Management";
        TransactionType: Integer;
}


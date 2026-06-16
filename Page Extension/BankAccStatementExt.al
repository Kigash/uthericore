pageextension 50005 "Bank Acc StatementExt" extends "Bank Account Statement"
{
    actions
    {
        addbefore("St&atement")
        {
            group(Main)
            {
                action(PostedStmnt)
                {
                    Caption = 'Posted Reconciliation';
                    Image = Report;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction()
                    var
                        BankAccStamnet: Record "Bank Account Statement";
                    begin
                        BankAccStamnet.Reset();
                        BankAccStamnet.SetRange(BankAccStamnet."Bank Account No.", Rec."Bank Account No.");
                        BankAccStamnet.SetRange(BankAccStamnet."Statement No.", Rec."Statement No.");
                        if BankAccStamnet.FindFirst() then begin
                            Report.Run(50008, TRUE, FALSE, BankAccStamnet);
                        end;
                    end;
                }
            }
        }
    }
}

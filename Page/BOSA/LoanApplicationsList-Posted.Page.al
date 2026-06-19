page 50207 "Loan Applications List-Posted"
{
    // version TL2.0

    Caption = 'Posted Loans';
    CardPageID = "Loan Application Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Security,Approval Request,Category 6,Category 7,Category 8';
    SourceTable = "Loan Application";
    SourceTableView = WHERE(Status = FILTER(Approved),
                            Posted = FILTER(true));
    UsageCategory = History;
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No"; PhoneNo)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Disbursal Date"; Rec."Disbursal Date")
                {
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                }
                field("Principal Overpayment"; Rec."Principal Overpayment")
                {
                    ApplicationArea = All;
                }
                field("Interest Overpayment"; Rec."Interest Overpayment")
                {
                    ApplicationArea = All;
                }
                field("Total Overpayment"; Rec."Total Overpayment")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field("Expected Balance"; Rec."Expected Balance")
                {
                    ApplicationArea = All;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    ApplicationArea = All;
                }
                field("Installment In Arrears"; Rec."Installment In Arrears")
                {
                    ApplicationArea = All;
                }
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }

                field("Last Payment Date"; LastPDate)
                {
                    ApplicationArea = All;
                }

                field("Top-up"; Rec."Top-up")
                {
                    ApplicationArea = All;
                }
                field("Disbursed By"; Rec."Disbursed By")
                {

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action("Loan Update")
            {
                ApplicationArea = Basic, Suite;
                Image = CoupledUsers;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = true;
                RunObject = codeunit "Interest Changes";
            }
            action("Loan Guarantors")
            {
                ApplicationArea = Basic, Suite;
                Image = CoupledUsers;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                begin
                    LoanGuarantor.FILTERGROUP(10);
                    LoanGuarantor.SETRANGE("Loan No.", Rec."No.");
                    LoanGuarantor.FILTERGROUP(0);
                    PAGE.RUN(50210, LoanGuarantor);
                end;
            }


            action("Loan Collateral")
            {
                ApplicationArea = Basic, Suite;
                Image = Lock;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    LoanCollateral.FILTERGROUP(10);
                    LoanCollateral.SETRANGE("Loan No.", Rec."No.");
                    LoanCollateral.FILTERGROUP(0);
                    PAGE.RUN(50209, LoanCollateral);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        BosaM: Codeunit "BOSA Management";
        Lprod: record "Loan Product Type";
        LoanNo: Code[20];
        Loans: Record "Loan Application";
        Memb: Record Member;
        Cust: record Customer;
        DCustL: Record "Detailed Cust. Ledg. Entry";
        DCustL2: Record "Detailed Cust. Ledg. Entry";
        DCustL3: Record "Detailed Cust. Ledg. Entry";
        CustL: Record "Cust. Ledger Entry";
        DocCount: Integer;
        BankRecon: Record "Bank Acc. Reconciliation";
        BankReconLine: Record "Bank Acc. Reconciliation Line";
        BankL: Record "Bank Account Ledger Entry";
        Gle: Record "G/L Entry";
        Gle2: Record "G/L Entry";
        ActualFee: Decimal;
        FeeCharged: Decimal;
        Diff: Decimal;
        Installments: Integer;
        LoanProductCharge: Record "Loan Product Charge";
        LGuar: Record "Loan Guarantor";
        LGuarBuff: Record "Loan Guarantor Buff";
        FosaM: Codeunit "FOSA Management";
        LineNo: Integer;
        GJLine: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        VendorLedger: Record "Vendor Ledger Entry";
        DetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        Customer: Record Customer;
    begin
        CurrPage.Editable(false);

        DCustL.Reset();
        if DCustL.FindSet() then
            DCustL.DeleteAll();

        CustL.Reset();
        if CustL.FindSet() then
            CustL.DeleteAll();

        Customer.Reset();
        if Customer.FindSet() then
            Customer.DeleteAll();

        DetailedVendorLedger.Reset();
        if DetailedVendorLedger.FindSet() then
            DetailedVendorLedger.DeleteAll();

        VendorLedger.Reset();
        if VendorLedger.FindSet() then
            VendorLedger.DeleteAll();


        BankL.Reset();
        if BankL.FindSet() then
            BankL.DeleteAll();

        Gle.Reset();
        if Gle.FindSet() then
            Gle.DeleteAll();

    end;

    trigger OnAfterGetRecord()
    var
        GlobalM: Codeunit "Global Management";
        ArrearsAmount: array[4] of Decimal;
        OverpaymentAmount: array[4] of Decimal;
        BosaM: Codeunit "BOSA Management";
        NoofDaysInArrears: Integer;
        NoofInstallmentInArrears: Integer;
        ClassificationCode: Code[100];
        ClassificationDesc: Text;
        ProvisioningPercent: Decimal;
        Customer: Record Customer;
    Begin
        LClassCode := '';
        PhoneNo := '';
        LastPDate := 0D;
        ArrearsAmount[1] := 0;
        ArrearsAmount[2] := 0;
        ArrearsAmount[3] := 0;
        ArrearsAmount[4] := 0;
        OverpaymentAmount[1] := 0;
        OverpaymentAmount[2] := 0;
        NoofDaysInArrears := 0;
        NoofInstallmentInArrears := 0;
        ClassificationDesc := '';
        Rec."Expected Balance" := 0;
        //If Rec."No." = '300103000000000101' then begin

        Rec.CalcFields("Outstanding Balance");
        if Rec."Outstanding Balance" > 0 then begin
            GlobalM.CalculateLoanArrearsAndOverpayment(Rec."No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
            Rec."Principal Arrears" := ArrearsAmount[1];
            Rec."Interest Arrears" := ArrearsAmount[2];
            Rec."Ledger Fee Arrears" := ArrearsAmount[3];
            Rec."Penalty Arrears" := ArrearsAmount[4];
            Rec."Principal Overpayment" := OverpaymentAmount[1];
            Rec."Interest Overpayment" := OverpaymentAmount[2];
            Rec."Total Overpayment" := OverpaymentAmount[1] + OverpaymentAmount[2];
            If Rec."Date of Completion" > Today then begin
                LoanSched.Reset();
                LoanSched.SetRange("Loan No.", Rec."No.");
                LoanSched.SetFilter("Repayment Date", '<=%1', Today);
                if LoanSched.FindLast() then begin
                    LoanSched2.Reset();
                    LoanSched2.SetRange("Loan No.", Rec."No.");
                    LoanSched2.SetFilter("Repayment Date", '>%1', Today);
                    if LoanSched2.FindFirst() then begin
                        Rec."Expected Balance" := LoanSched2."Loan Amount" + LoanSched."Interest Installment";
                    end;
                end else begin
                    Rec."Expected Balance" := Rec."Approved Amount";
                end;
            end;
            ArrearsAmount[4] := ArrearsAmount[1] + ArrearsAmount[2];

            If ArrearsAmount[4] > 0 then begin
                ArrearsAmount[4] := ArrearsAmount[4];
                StyleExprTxt := 'unfavorable';//Red
            end else begin
                ArrearsAmount[4] := 0;
                StyleExprTxt := 'Favorable';//Green
            end;

            Rec."Total Arrears" := ArrearsAmount[4];
            //"Total Arrears" := ArrearsAmount[1] + ArrearsAmount[2] + ArrearsAmount[3] + ArrearsAmount[4];
            BosaM.CalculateDaysAndInstallmentsInArrearsDefaulter(Rec."No.", (ArrearsAmount[4]), NoofDaysInArrears, NoofInstallmentInArrears, Today);
            BosaM.GetClassificationClassDetails(NoofDaysInArrears, ClassificationCode, ClassificationDesc, ProvisioningPercent);
            Rec."Days In Arrears" := NoofDaysInArrears;
            Rec."Installment In Arrears" := NoofInstallmentInArrears;
            Rec."Classification" := ClassificationDesc;
            Rec.Modify();
        end else begin
            GlobalM.CalculateLoanArrearsAndOverpayment(Rec."No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
            Rec."Principal Arrears" := 0;
            Rec."Interest Arrears" := 0;
            Rec."Ledger Fee Arrears" := 0;
            Rec."Penalty Arrears" := 0;
            Rec."Total Arrears" := 0;
            Rec."Days In Arrears" := 0;
            Rec."Installment In Arrears" := 0;
            Rec."Classification" := '';
            StyleExprTxt := 'Favorable';//Green
            Rec."Principal Overpayment" := OverpaymentAmount[1];
            Rec."Interest Overpayment" := OverpaymentAmount[2];
            Rec.Modify();
        end;

        Dcust.Reset();
        Dcust.SetRange("Customer No.", Rec."No.");
        Dcust.SetFilter("Credit Amount", '>%1', 0);
        if Dcust.FindLast() then begin
            LastPDate := Dcust."Posting Date";
        end;

        if (Rec."Next Due Date" = 0D) or (Rec."Date of Completion" = 0D) then begin
            Rec.Validate("Disbursal Date");
            Rec.Modify();
        end;


        /*if not Customer.Get(Rec."No.") then
            BosaM.CreateLoanAccount(Rec);*/


        //LoanClass.Reset();
        //LoanClass.SetRange("Loan No.", Rec."No.");
        //If LoanClass.FindFirst() then begin
        //LClassCode := LoanClass."Class Description";
        //ArrearsAmount := LoanClass."Total Arrears";
        // LastPDate := LoanClass."Last Payment Date";
        //end;
        if Memb.Get(Rec."Member No.") then
            PhoneNo := Memb."Phone No.";
    End;

    var
        LoanGuarantor: Record "Loan Guarantor";
        LoanCollateral: Record "Loan Collateral";
        LoanApp: Record "Loan Application";
        DateForm: DateFormula;
        LoanUpd: Record LoansUpdate;
        LoanProd: Record "Loan Product Type";
        LoanClass: Record "Loan Classification Entry";
        LClassCode: Code[100];
        ArrearsAmount: Decimal;
        LastPDate: Date;
        StyleExprTxt: Text;
        Dcust: Record "Detailed Cust. Ledg. Entry";
        PhoneNo: Code[50];
        Memb: Record Member;
        LoanSched: Record "Loan Repayment Schedule";
        LoanSched2: Record "Loan Repayment Schedule";
    //LoanOffset: Record "50106";
}


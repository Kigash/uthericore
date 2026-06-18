pageextension 50002 DetailedVendLedgEntryExt extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Transaction Type Code"; Rec."Transaction Type Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Reversed; Reversed)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Document No.")
        {
            field(ExternalDocNo; ExternalDocNo)
            {
                Editable = false;
                Caption = 'External Document No';
            }
            field(Description; Description)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Entry No.")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                Caption = 'Created At';
                Editable = false;
                ApplicationArea = All;
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                Caption = 'Modified At';
                Editable = false;
                ApplicationArea = All;
            }
        }

        modify("Entry Type")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Initial Entry Due Date")
        {
            Visible = false;
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("Unapply Entries")
        {
            group(main)
            {
                action(Reverse)
                {
                    Image = ReverseLines;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    var
                        GLEntry: Record "G/L Entry";
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        GLEntry.Reset();
                        GLEntry.SetRange(GLEntry."Document No.", Rec."Document No.");
                        GLEntry.SetRange(GLEntry."Transaction No.", Rec."Transaction No.");
                        GLEntry.SetRange(Reversed, false);
                        if GLEntry.FindSet() then begin
                            repeat
                                ReversalEntry.SetHideWarningDialogs();
                                ReversalEntry.SetHideDialog(true);
                                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");

                                descriptionFilterText := COPYSTR(Description, 1, 35);
                                //  Message('%1', descriptionFilterText);
                                if descriptionFilterText = 'Agency Banking deposit - Member No-' then begin

                                    accTypeCode := CopyStr(Rec."Vendor No.", StrLen(Rec."Vendor No.") - 1, 2);
                                    if accTypeCode = '04' then begin
                                        CLEAR(SMSText);
                                        SMSText.ADDTEXT(STRSUBSTNO('Dear ' + Format(fnGetMemberName(Rec."Vendor No.")) + ', your deposit transaction worth KSh.' + Format(Rec.Amount) + ' has been reversed at ' + Format(Time)));
                                        GlobalM.CreateSMSEntry(fnGetMemberTellNo(Rec."Vendor No."), SMSText, 'REVERSAL');
                                    end;
                                end;



                            until GLEntry.Next() = 0;
                        end;
                    end;
                }
            }
        }
    }
    local procedure fnGetMemberName(vendNo: Code[34]) fullName: Text[200]
    var
        vend: Record Vendor;
        memb: Record Member;
    begin
        vend.Reset();
        vend.SetRange("No.", vendNo);
        if vend.Find('-') then begin
            memb.Reset();
            memb.SetRange("No.", vend."Member No.");
            if memb.Find('-') then
                fullName := memb."Full Name";
            exit(fullName);
        end;
    end;

    local procedure fnGetMemberTellNo(vendNo: Code[34]) cellNo: Text[15]
    var
        vend: Record Vendor;
        memb: Record Member;
    begin
        vend.Reset();
        vend.SetRange("No.", vendNo);
        if vend.Find('-') then begin
            memb.Reset();
            memb.SetRange("No.", vend."Member No.");
            if memb.Find('-') then
                cellNo := memb."Phone No.";
            exit(cellNo);
        end;
    end;

    var
        Description: Text;
        Reversed: Boolean;
        ExternalDocNo: Code[150];
        accTypeCode: Code[10];
        SMSText: BigText;
        GlobalM: Codeunit "Global Management";
        firstHyphenPosition: Integer;
        secondHyphenPosition: Integer;
        descriptionFilterText: Text[200];


    trigger OnAfterGetRecord()
    var
        VendL: Record "Vendor Ledger Entry";
    begin
        /*
         Description := '';
         Reversed := false;
         ExternalDocNo := '';

         VendL.Reset();
         VendL.SetRange("Entry No.", Rec."Vendor Ledger Entry No.");
         if VendL.FindFirst() then begin
             Description := VendL.Description;
             Reversed := VendL.Reversed;
             ExternalDocNo := VendL."External Document No.";
         end;
         */
    end;

    trigger OnAfterGetCurrRecord()
    var
        VendL: Record "Vendor Ledger Entry";
    begin
        Description := '';
        Reversed := false;
        ExternalDocNo := '';

        VendL.Reset();
        VendL.SetRange("Entry No.", Rec."Vendor Ledger Entry No.");
        if VendL.FindFirst() then begin
            Description := VendL.Description;
            Reversed := VendL.Reversed;
            ExternalDocNo := VendL."External Document No.";
        end;
    end;
}
